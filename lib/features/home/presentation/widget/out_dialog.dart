import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myfarm/features/home/application/get_items_list_data.dart';
import 'package:myfarm/features/home/presentation/widget/update_button.dart';
import 'package:myfarm/features/production/domain/entities/items_movement.dart';
import 'package:myfarm/features/production/domain/repositories/ambers_repository.dart';
import 'package:myfarm/features/production/application/add_production_provider.dart';
import 'package:reactive_forms/reactive_forms.dart';

class MyOutDialog extends ConsumerStatefulWidget {
  const MyOutDialog({super.key, required this.title, required this.date});
  final String title;
  final DateTime date;
  //final DailyDataModel content;

  @override
  ConsumerState<MyOutDialog> createState() => _MyOutDialogState();
}

class _MyOutDialogState extends ConsumerState<MyOutDialog> {
  //late FormGroup myForm;
  final outForm = FormGroup({
    'notes': FormControl<String>(
        validators: [Validators.required, Validators.minLength(7)]),
    'item_code': FormControl<String>(validators: [Validators.required]),
    'type_movement':
        FormControl<String>(value: 'خارج', validators: [Validators.required]),
    'movement_date': FormControl<DateTime>(validators: [Validators.required]),
    'amber_id': FormArray<num>([]),
    'quantity': FormArray<String>([])
  });

  bool isItemsLoaded = false; //is itemeName loaded
  String itemCode = ''; //itemCode selected from ItemsDropDown Menu
  List<ItemsMovement> newItems =
      <ItemsMovement>[]; //new Items that will be sended into database

  bool isPressed = false; //
//array that keep the out quantity foreach amber
  FormArray<String> get selectedQuantities =>
      outForm.control('quantity') as FormArray<String>;
  FormArray<num> get ambersId => outForm.control('amber_id') as FormArray<num>;
  //static
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // TODO: test  dispose
    super.dispose();
    // noteController.dispose();
    // controller.forEach((element) {
    //   element.dispose();
    // });
  }

  @override
  Widget build(BuildContext context) {
    print('build out dialog');

    outForm.control('movement_date').value = widget.date;
    final AsyncValue<List<Item>> items = ref.watch(getItemsListProvider);
    final amberMap = ref.watch(fetchAmberProvider);

    return SingleChildScrollView(
      child: AlertDialog(
        //titlePadding: EdgeInsets.all(0),
        icon: Icon(
          Icons.output_sharp,
          color: Theme.of(context).colorScheme.onBackground,
          size: 40.0,
        ),
        backgroundColor: const Color(0xffF3F6FC),
        elevation: 15.0,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(32.0))),
        title: Text(widget.title,
            style: Theme.of(context).textTheme.headlineSmall),
        content: Container(
          height: MediaQuery.of(context).size.height * 0.4,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Theme.of(context).cardColor,
          ),
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.manual,
            child: Card(
              child: Column(
                  //mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  textDirection: TextDirection.rtl,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: ReactiveForm(
                        formGroup: outForm,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.min,
                          textDirection: TextDirection.rtl,
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(12.0),
                              child: Text('نوع الخارج'),
                            ),
                            items.when(
                                data: (data) {
                                  return Expanded(
                                    child: ReactiveDropdownField(
                                      formControlName: 'item_code',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                      // menuStyle: Theme.of(context)
                                      //     .dropdownMenuTheme
                                      //     .menuStyle,
                                      // menuHeight: 150,
                                      menuMaxHeight: 150,
                                      // requestFocusOnTap: true,
                                      onChanged: (control) => {
                                        //check if the list of items has been loaded then reset the contoroller values

                                        setState(() {
                                          ///reset the last values of selectedQuantities
                                          selectedQuantities.value!.clear();

                                          ///check if the ambers list is loaded then update selectedQuantities array to 0s
                                          if (ambersId.controls.isNotEmpty) {
                                            for (int i = 0;
                                                i < ambersId.controls.length;
                                                i++) {
                                              selectedQuantities.updateValue(
                                                ambersId.value!
                                                    .map<String>((e) => '0')
                                                    .toList(),
                                                updateParent: true,
                                              );
                                            }
                                          }

                                          isItemsLoaded = true;
                                          //newItems.clear();
                                          //set the itemCode to be inserted into database to the new selected item in dropdown
                                          outForm
                                              .control('item_code')
                                              .reset(value: control.value);
                                          outForm.control('notes').reset();

                                          // itemCode = control.value;
                                        }),
                                      },
                                      // dropdownMenuEntries:
                                      items: data.map<DropdownMenuItem<String>>(
                                          (ambData) {
                                        return DropdownMenuItem<String>(
                                          value: ambData.itemCode,
                                          child: Text(ambData.itemName),
                                        );
                                      }).toList(),
                                    ),
                                  );
                                },
                                error: (error, StackTrace r) =>
                                    Text(error.toString()),
                                loading: () =>
                                    const CircularProgressIndicator.adaptive())
                          ],
                        ),
                      ),
                    ),
                    Center(
                      child: isItemsLoaded
                          ? amberMap.when(
                              data: (amber) {
                                selectedQuantities.controls.isEmpty
                                    ? setState(() {
                                        //add the ambers list coming from database into the ambersId array
                                        selectedQuantities.addAll(amber
                                            .map((id) =>
                                                FormControl<String>(value: '0'))
                                            .toList());
                                        if (ambersId.value!.isEmpty) {
                                          ambersId.addAll(amber
                                              .map((id) => FormControl<num>(
                                                  value: id.id))
                                              .toList());
                                        }
                                      })
                                    : {};

                                return ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: amber.length,
                                    itemBuilder: (context, index) {
                                      final item = amber[index];

                                      return Center(
                                        child: ListTile(
                                            // selected: true,
                                            selectedColor:
                                                Theme.of(context).primaryColor,
                                            title: Text(
                                              'عنبر: \t ${item.id.toString()}',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall
                                                  ?.copyWith(
                                                    fontSize: 14,
                                                    color: const Color.fromARGB(
                                                        255, 16, 8, 22),
                                                  ),
                                              textDirection: TextDirection.rtl,
                                            ),
                                            leading: Container(
                                                alignment:
                                                    AlignmentDirectional.center,
                                                width: 60.0,
                                                height: 80.0,
                                                child: ReactiveForm(
                                                  formGroup: outForm,
                                                  child: ReactiveFormArray<
                                                          String>(
                                                      formArray:
                                                          selectedQuantities,
                                                      builder: (context, array,
                                                          child) {
                                                        if (selectedQuantities
                                                            .controls
                                                            .isNotEmpty) {
                                                          return ReactiveTextField(
                                                            key: ObjectKey(
                                                                selectedQuantities),
                                                            formControl:
                                                                selectedQuantities
                                                                            .controls[
                                                                        index]
                                                                    as FormControl<
                                                                        String>,
                                                            keyboardType:
                                                                const TextInputType
                                                                    .numberWithOptions(),
                                                            // .numberWithOptions(
                                                            // decimal:
                                                            //     true),
                                                            textInputAction:
                                                                TextInputAction
                                                                    .next,
                                                            validationMessages: {
                                                              'required':
                                                                  (error) =>
                                                                      "مطلوب"
                                                            },
                                                          );
                                                        } else {
                                                          return const SizedBox();
                                                        }
                                                      }),
                                                ))),
                                      );
                                    });
                              },
                              error: (error, StackTrace r) =>
                                  Text(error.toString()),
                              loading: () =>
                                  const CircularProgressIndicator.adaptive(),
                            )
                          : const Padding(
                              padding: EdgeInsets.symmetric(vertical: 8.0),
                              child: Text('قم بتحديد نوع الخارج'),
                            ),
                    ),
                    ReactiveForm(
                      formGroup: outForm,
                      child: ReactiveValueListenableBuilder(
                          formControlName: 'amber_id',
                          builder: (context, control, child) {
                            if (selectedQuantities.controls.every((element) =>
                                    element.status == ControlStatus.valid) &&
                                outForm.control('item_code').status ==
                                    ControlStatus.valid) {
                              return ReactiveTextField(
                                //controller: noteController,
                                formControlName: 'notes',
                                showErrors: (control) =>
                                    control.invalid &&
                                    control.touched &&
                                    control.dirty,
                                style: Theme.of(context).textTheme.bodyMedium,
                                textDirection: TextDirection.rtl,
                                decoration: const InputDecoration(
                                    fillColor: Colors.white54,
                                    hintTextDirection: TextDirection.ltr,
                                    labelText: 'ملاحظات الخارج'),
                              );
                            }
                            return const SizedBox();
                          }),
                    ),
                    ReactiveForm(
                      formGroup: outForm,
                      child: ReactiveFormConsumer(
                        builder: (context, formGroup, child) {
                          if (outForm.valid && outForm.control('notes').dirty) {
                            return const UpdateButton();
                          } else {
                            return const SizedBox();
                          }
                        },
                      ),
                    ),
                  ]),
            ),
          ),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 100.0,
                child: ElevatedButton(
                  style: Theme.of(context).elevatedButtonTheme.style,
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('إغلاق'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class MyErrorDialog extends StatelessWidget {
  const MyErrorDialog({super.key, required this.icon, required this.content});
  final IconData icon;
  final String content;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: Icon(
        icon,
        color: Theme.of(context).colorScheme.error,
      ),
      title: const Text('حالة البيانات'),
      content: Text(content.toString()),
      actions: <Widget>[
        Center(
          child: TextButton(
              child: const Text('موافق'),
              onPressed: () => {
                    Navigator.of(context).pop(),
                  }),
        ),
      ],
    );
  }
}
