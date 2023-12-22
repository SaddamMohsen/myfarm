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
    'notes': FormArray<String>([]),
    // (
    //     validators: [Validators.required, Validators.minLength(5)]),
    'item_code': FormControl<String>(validators: [Validators.required]),
    'type_movement':
        FormControl<String>(value: 'خارج', validators: [Validators.required]),
    'movement_date': FormControl<DateTime>(validators: [Validators.required]),
    'amber_id': FormArray<num>([]),
    'quantity': FormArray<String>([])
  });

  bool isItemsLoaded = false; //is itemeName loaded
  String itemCode = ''; //itemCode selected from ItemsDropDown Menu
  // List<ItemsMovement> newItems =
  //     <ItemsMovement>[]; //new quantities that will be sended into database

//array that keep the out quantity foreach amber
  FormArray<String> get selectedQuantities =>
      outForm.control('quantity') as FormArray<String>;
  //array that keep a list of ambers id
  FormArray<num> get ambersId => outForm.control('amber_id') as FormArray<num>;

  //array to keepnotes for each quantity
  FormArray<String> get outNotes =>
      outForm.control('notes') as FormArray<String>;
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
    //print('build out dialog');

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
        backgroundColor: Theme.of(context).dialogBackgroundColor,
        elevation: 15.0,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(32.0))),
        title: Text(widget.title,
            style: Theme.of(context).textTheme.headlineSmall),
        content: Container(
          height: MediaQuery.of(context).size.height * 0.4,
          width: MediaQuery.of(context).size.width,
          //padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 0.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Theme.of(context).dialogBackgroundColor,
            //color: Theme.of(context).cardColor,
          ),
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.manual,
            child: Card(
              color: Theme.of(context).dialogBackgroundColor,
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
                            Container(
                              padding: const EdgeInsets.all(12.0),
                              child: const Text('نوع الخارج'),
                            ),
                            items.when(
                                data: (data) {
                                  return Expanded(
                                    // width: double.infinity,
                                    //height: 51,
                                    child: ReactiveDropdownField(
                                      decoration: const InputDecoration(
                                          contentPadding: EdgeInsets.all(5)),
                                      formControlName: 'item_code',
                                      alignment: AlignmentDirectional.topEnd,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,

                                      menuMaxHeight: 150,
                                      // requestFocusOnTap: true,
                                      onChanged: (control) => {
                                        /// when item_code dropdown value changed then
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
                                              outNotes.updateValue(
                                                ambersId.value!
                                                    .map<String>((e) => ' ')
                                                    .toList(),
                                                //updateParent: true,
                                              );
                                            }
                                          }

                                          isItemsLoaded = true;
                                          //newItems.clear();
                                          //set the itemCode to be inserted into database to the new selected item in dropdown
                                          outForm
                                              .control('item_code')
                                              .reset(value: control.value);
                                          // outForm
                                          //     .control('notes')
                                          //     .reset(value: ' ');

                                          // itemCode = control.value;
                                        }),
                                      },
                                      // dropdownMenuEntries:
                                      items: data.map<DropdownMenuItem<String>>(
                                          (item) {
                                        return DropdownMenuItem<String>(
                                          value: item.itemCode,
                                          child: Text(item.itemName),
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
                      ///if the item list is loaded then create a list of ambers
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
                                        outNotes.addAll(amber
                                            .map((id) =>
                                                FormControl<String>(value: ' '))
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
                                          // selectedColor:
                                          //     Theme.of(context).primaryColor,
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
                                            margin:
                                                const EdgeInsets.only(top: 15),
                                            // padding: const EdgeInsets.symmetric(
                                            //     vertical: 2),
                                            alignment:
                                                AlignmentDirectional.center,
                                            width: 70.0,
                                            height: 65.0,
                                            child: ReactiveForm(
                                              formGroup: outForm,
                                              child: ReactiveFormArray<String>(
                                                  formArray: selectedQuantities,
                                                  builder:
                                                      (context, array, child) {
                                                    if (selectedQuantities
                                                        .controls.isNotEmpty) {
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
                                                        decoration:
                                                            InputDecoration(
                                                          hintText: 'الكمية',
                                                          hintStyle: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .bodySmall!
                                                              .copyWith(
                                                                  color: Theme.of(
                                                                          context)
                                                                      .colorScheme
                                                                      .outlineVariant),
                                                        ),
                                                        // .numberWithOptions(
                                                        // decimal:
                                                        //     true),
                                                        textInputAction:
                                                            TextInputAction
                                                                .next,
                                                        validationMessages: {
                                                          'required': (error) =>
                                                              "مطلوب"
                                                        },
                                                      );
                                                    } else {
                                                      return const SizedBox();
                                                    }
                                                  }),
                                            ),
                                          ),
                                          subtitle: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 8,
                                                      horizontal: 2),
                                              alignment:
                                                  AlignmentDirectional.center,
                                              width: 60.0,
                                              height: 60.0,
                                              child: ReactiveForm(
                                                formGroup: outForm,
                                                child: ReactiveFormArray<
                                                        String>(
                                                    formArray: outNotes,
                                                    builder: (context, array,
                                                        child) {
                                                      // if (outNotes.controls
                                                      //     .isNotEmpty) {
                                                      return ReactiveTextField(
                                                        key:
                                                            ObjectKey(outNotes),
                                                        formControl: outNotes
                                                                .controls[index]
                                                            as FormControl<
                                                                String>,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodySmall,
                                                        textDirection:
                                                            TextDirection.rtl,
                                                        decoration:
                                                            InputDecoration(
                                                                hintTextDirection:
                                                                    TextDirection
                                                                        .rtl,
                                                                label: Text(
                                                                  'تفاصيل الخارج',
                                                                  style: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .bodySmall!
                                                                      .copyWith(
                                                                          color: Theme.of(context)
                                                                              .colorScheme
                                                                              .outline
                                                                              .withBlue(100)),
                                                                ),
                                                                hintStyle: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodySmall!
                                                                    .copyWith(
                                                                        color: Theme.of(context)
                                                                            .colorScheme
                                                                            .outlineVariant),
                                                                hintText:
                                                                    'تفاصيل الخارج'),
                                                        // .numberWithOptions(
                                                        // decimal:
                                                        //     true),
                                                        textInputAction:
                                                            TextInputAction
                                                                .next,
                                                        validationMessages: {
                                                          'required': (error) =>
                                                              "مطلوب"
                                                        },
                                                      );
                                                      // } else {
                                                      //   return const Text(
                                                      //       'hhhhh');
                                                      // }
                                                    }),
                                              )),
                                        ),
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
                    /*ReactiveForm(
                      formGroup: outForm,
                      child: ReactiveValueListenableBuilder(
                          formControlName: 'amber_id',
                          builder: (context, control, child) {
                            ///check if the quantities list values is valid then show outnote textfield
                            if (selectedQuantities.controls.every((element) =>
                                    element.status == ControlStatus.valid) &&
                                outForm.control('item_code').status ==
                                    ControlStatus.valid) {
                              return Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 5),
                                height: 50,
                                child: Text('was notes'),
                                // ReactiveTextField(
                                //   //controller: noteController,
                                //   formControlName: 'notes',
                                //   showErrors: (control) =>
                                //       control.invalid &&
                                //       control.touched &&
                                //       control.dirty,
                                //   style: Theme.of(context).textTheme.bodyMedium,
                                //   textDirection: TextDirection.rtl,
                                //   decoration: InputDecoration(
                                //       //fillColor: Colors.white54,
                                //       hintTextDirection: TextDirection.ltr,
                                //       labelText: 'ملاحظات الخارج',
                                //       labelStyle: Theme.of(context)
                                //           .textTheme
                                //           .bodySmall),
                                // ),
                              );
                            }
                            return const SizedBox();
                          }),
                    ),*/
                    ReactiveForm(
                      formGroup: outForm,
                      child: ReactiveFormConsumer(
                        builder: (context, formGroup, child) {
                          ///check if the form values is valid and out notes contain text
                          ///then show update button else show sizeBox
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
