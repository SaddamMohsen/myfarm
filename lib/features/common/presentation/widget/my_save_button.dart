import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myfarm/features/common/presentation/widget/my_button.dart';
import 'package:myfarm/features/production/application/add_production_provider.dart';
import 'package:myfarm/features/production/domain/entities/dailydata.dart';
import 'package:myfarm/features/common/presentation/widget/my_alert_dialog.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../production/application/add_production_notifier.dart';

//Button to save data that can be requested from add_production_page or from Update form model
class SaveButton extends ConsumerStatefulWidget {
  const SaveButton({super.key, required this.type, this.rowId = 0});
  final String type;
  final int rowId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SaveButtonState();
}

class _SaveButtonState extends ConsumerState<SaveButton> {
  Future<void>? _pendingAddProduction;
  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue>(
        addProductionControllerProvider,
        (_, state) => state.unwrapPrevious().when(
              error: (error, stackTrace) {
                showDialog<void>(
                  context: context,
                  builder: (context) => AlertDialog(
                    icon: const Icon(
                      Icons.warning,
                      size: 50,
                      color: Color.fromARGB(255, 240, 52, 77),
                    ),
                    title: const Text('خطأ'),
                    content: Text(
                      'للأسف حدث خطأ اثناء رفع البيانات \n  بيانات الخطأ\n ${error.toString()}\n ',
                      style: Theme.of(context).textTheme.headlineMedium,
                      textAlign: TextAlign.center,
                    ),
                    actions: <Widget>[
                      Center(
                        child: MyButton(
                            lable: 'إغلاق',
                            onTap: () => {
                                  if (widget.type == "save")
                                    ref
                                        .read(resetStepperProvider.notifier)
                                        .state = 0,

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
                    title: const Text('حالة البيانات'),
                    content: const Text(
                      'تم تحديث البيانات  بنجاح',
                      textAlign: TextAlign.center,
                    ),
                    actions: <Widget>[
                      Center(
                        child: MyButton(
                            lable: 'موافق',
                            onTap: () => {
                                  if (widget.type == "save")
                                    ref
                                        .read(resetStepperProvider.notifier)
                                        .state = 0,
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
        future: _pendingAddProduction,
        builder: (context, snapshot) {
          // Compute whether there is an error state or not.
          // The connectionState check is here to handle when the operation is retried.
          bool isErrored = snapshot.hasError &&
              snapshot.connectionState != ConnectionState.waiting;
          final isLoading = snapshot.connectionState == ConnectionState.waiting
              ? true
              : false;
          return ReactiveFormConsumer(
            builder: (context, form, child) {
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
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                        isErrored
                                            ? Theme.of(context)
                                                .colorScheme
                                                .error
                                            : null,
                                      ),
                                    ),
                                onPressed: () {
                                  form.markAllAsTouched();
                                  form.unfocus();
                                  if (form.invalid) {
                                    showDialog(
                                      context: context,
                                      builder: ((context) => MyAlertDialog(
                                          title:
                                              'خطأ في القيم المدخله الرجاء التأكد من صحة الارقام',
                                          content: form.value.toString())),
                                    );
                                  } else {
                                    DailyDataModel todayData =
                                        DailyDataModel.fromJson(form.value);

                                    if (widget.type == "save") {
                                      final future = ref
                                          .read(addProductionControllerProvider
                                              .notifier)
                                          .addDailyData(todayData)
                                          .then((value) => value == false
                                              ? {
                                                  //remove the amber from the dropDown list
                                                  ref
                                                      .read(
                                                          ambersProviderNotifier
                                                              .notifier)
                                                      .remove(todayData.amberId
                                                          .toString()),

                                                  //reset the dropdown list
                                                  form
                                                      .control('amber_id')
                                                      .value = -1,
                                                }
                                              : '');

                                      //remove the current ambers from the l

                                      setState(() {
                                        _pendingAddProduction = future;
                                      });
                                    }
                                    //when request save button for update
                                    else {
                                      // print()

                                      final future = ref
                                          .watch(addProductionControllerProvider
                                              .notifier)
                                          .updateDailyData(
                                              todayData, widget.rowId)
                                          .then((value) => value == false
                                              ? {
                                                  // print('reset form'),
                                                  form.unfocus(),
                                                  form.reset()

                                                  // formGroup.reset(updateParent: true)
                                                }
                                              : {})
                                          .onError((error, stackTrace) =>
                                              throw AssertionError(
                                                  error.toString()));
                                      // insertController;
                                      setState(() {
                                        _pendingAddProduction = future;
                                      });
                                    }
                                  }
                                },
                                child: Text(
                                  'حفظ البيانات',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(color: Colors.black),
                                ),
                              )
                            : const SizedBox(),
                      ),
                      if (snapshot.connectionState ==
                          ConnectionState.waiting) ...[
                        const CircularProgressIndicator(),
                        const SizedBox(width: 40),
                      ]
                    ]),
              );
            },
          );
        });
  }
}
