import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myfarm/features/common/presentation/widget/my_alert_dialog.dart';
import 'package:myfarm/features/common/presentation/widget/my_button.dart';
import 'package:myfarm/features/home/application/insert_out_items.dart';
import 'package:myfarm/features/production/domain/entities/items_movement.dart';
import 'package:reactive_forms/reactive_forms.dart';

///The Button to insert a list of out Items into database
class UpdateButton extends ConsumerStatefulWidget {
  const UpdateButton({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UpdateButtonState();
}

class _UpdateButtonState extends ConsumerState<UpdateButton> {
  // The pending addTodo operation. Or null if none is pending.
  Future<void>? _pendingAddOutItems;

  @override
  void initState() {
    ///TODO implement testing
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('in update btn');
    ref.listen<AsyncValue>(
        insertOutItemsControllerProvider,
        (_, state) => state.when(
              error: (error, stackTrace) {
                showDialog<void>(
                  context: context,
                  builder: (context) => AlertDialog(
                    icon: const Icon(
                      Icons.warning,
                      color: Color.fromARGB(255, 240, 52, 77),
                    ),
                    title: const Text('خطأ'),
                    content: Text(
                      'للأسف حدث خطأ اثناء رفع البيانات \n بيانات الخطأ \n ${error.toString()}\n ',
                      textAlign: TextAlign.center,
                    ),
                    actions: <Widget>[
                      Center(
                        child: MyButton(
                            lable: 'موافق',
                            onTap: () => {
                                  Navigator.of(context).pop(),
                                  //ref.read(resetStepperProvider.notifier),
                                }),
                      ),
                    ],
                  ),
                );
              },
              data: (data) {
                showDialog<void>(
                  context: context,
                  builder: (context) => AlertDialog(
                    icon: Icon(
                      Icons.thumb_up_rounded,
                      color: Colors.green[500],
                    ),
                    title: const Text('نجاح العملية'),
                    content: const Text(
                      'تم تحديث البيانات  بنجاح',
                      textAlign: TextAlign.center,
                    ),
                    actions: <Widget>[
                      Center(
                        child: MyButton(
                            lable: 'موافق',
                            onTap: () => {
                                  Navigator.of(context).pop(),
                                }),
                      ),
                    ],
                  ),
                );
              },
              loading: () => const CircularProgressIndicator(),
            ));

    return FutureBuilder(
      // We listen to the pending operation, to update the UI accordingly.
      future: _pendingAddOutItems,
      builder: (context, snapshot) {
        // Compute whether there is an error state or not.
        // The connectionState check is here to handle when the operation is retried.
        final isErrored = snapshot.hasError &&
            snapshot.connectionState != ConnectionState.waiting;
        final isLoading =
            snapshot.connectionState == ConnectionState.waiting ? true : false;
        return ReactiveFormConsumer(builder: (context, formGroup, child) {
          return Container(
            padding: const EdgeInsets.all(0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              textDirection: TextDirection.rtl,
              children: [
                Expanded(
                  child: !isLoading
                      ? ElevatedButton(
                          style: Theme.of(context)
                              .elevatedButtonTheme
                              .style
                              ?.copyWith(
                                backgroundColor: MaterialStateProperty.all(
                                  isErrored
                                      ? Theme.of(context).colorScheme.error
                                      : null,
                                ),
                              ),
                          onPressed: () {
                            if (formGroup.valid) {
                              dynamic selectedQuantity =
                                  formGroup.control('quantity').value;

                              dynamic selectedAmber =
                                  formGroup.control('amber_id').value;
                              List<ItemsMovement> newItems = [];
                              for (var i = 0;
                                  i < selectedQuantity.length;
                                  i++) {
                                if (selectedQuantity[i].compareTo('0') != 0 &&
                                    selectedQuantity[i] != '') {
                                  ///TODO find a way to make this better
                                  newItems.add(ItemsMovement.fromJson({
                                    'amber_id': selectedAmber[i],
                                    'item_code':
                                        formGroup.control('item_code').value,

                                    //.toString(),
                                    'type_movement': 'خارج',
                                    'movement_date': formGroup
                                        .control('movement_date')
                                        .value as DateTime,
                                    'quantity':
                                        formGroup.control('quantity.$i').value,
                                    'notes': formGroup.control('notes').value,
                                  }));
                                }
                              }

                              // We keep the future returned by addTodo in a variable
                              final future = ref
                                  .read(
                                      insertOutItemsControllerProvider.notifier)
                                  .handle(newItems)
                                  .then(
                                      //if the value is not equal true so the operation success reset the form
                                      (value) => value == false
                                          ? {
                                              // print('reset form'),
                                              formGroup.unfocus(),
                                              formGroup
                                                  .control('item_code')
                                                  .reset(),
                                              formGroup
                                                  .control('notes')
                                                  .reset(),
                                              formGroup
                                                  .control('quantity')
                                                  .reset(),
                                              // formGroup.reset(updateParent: true)
                                            }
                                          : {});

                              // We store that future in the local state
                              setState(() {
                                _pendingAddOutItems = future;
                              });
                              //if there is error in the form show dialog
                            } else {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return const MyAlertDialog(
                                      title: 'خطأ',
                                      content:
                                          "خطأ في البيانات المدخله يرجى التأكد من صحة البيانات");
                                },
                              );
                            }
                          },
                          child: const Text('حفظ البيانات'),
                        )
                      : const SizedBox(),
                ),

                // The operation is pending, let's show a progress indicator
                if (snapshot.connectionState == ConnectionState.waiting) ...[
                  //const Center(),
                  const Padding(
                      padding: EdgeInsets.all(10),
                      child: CircularProgressIndicator(
                        strokeAlign: 1,
                        //value: 1,
                      )),
                  const SizedBox(
                    width: 120,
                  ),
                ]
              ],
            ),
          );
        });
      },
    );
  }
}
