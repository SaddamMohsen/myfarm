
import 'package:flutter/material.dart';

import 'package:myfarm/features/production/presentation/add_production_provider.dart';

//import 'package:flutter/services.dart';
import 'package:myfarm/features/production/domain/dailydata.dart';
//import 'package:flutter/services.dart';
//import 'package:myfarm/models/dailydata.dart';
//import 'package:myfarm/routes.dart';
import 'package:myfarm/utilities/constants.dart';

import 'package:myfarm/widgets/my_save_button.dart';
import 'package:reactive_forms/reactive_forms.dart';

//import 'package:myfarm/provider/amber_controller.dart';

import 'package:myfarm/widgets/next_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ignore: camel_case_types
enum inputFormControl {
  amber_id,
  prodDate,
  prodTray,
  prodCarton,
  outTray,
  outCarton,
  outEggsNote,
  incom_feed,
  intak_feed,
  death
}

class AddProduction extends StatefulWidget {
  const AddProduction({Key? key, required this.prodDate}) : super(key: key);
  final DateTime prodDate;
  @override
  State<AddProduction> createState() => _AddProductionState();
}

class _AddProductionState extends State<AddProduction> {
  DailyDataModel? todayData;
  DateTime get prodDate => widget.prodDate;
  int currentStep = 0;

  @override
  void initState() {
    super.initState();
    //prodDate = widget.prodDate;
    print(prodDate);
    /*try {
      prodDate = Get.arguments['localDate'];
    } catch (e) {
      print("Error in get argument ${e.toString()}");
    }*/
  }

  final form = FormGroup({
    inputFormControl.amber_id.name: FormControl<int>(value: -1),
    'prodDate': FormControl<DateTime>(),
    // 'eggs': FormGroup({
    'prodTray': FormControl<int>(
      value: 0,
      validators: [
        Validators.required,
        Validators.number,
        Validators.pattern(kTrayNumberPattern)
      ],
    ),
    'prodCarton': FormControl<int>(
        value: 0, validators: [Validators.required, Validators.number]),
    inputFormControl.outTray.name: FormControl<int>(value: 0, validators: [
      Validators.required,
      Validators.number,
      Validators.pattern(kTrayNumberPattern)
    ]),
    inputFormControl.outCarton.name:
        FormControl<int>(value: 0, validators: [Validators.number]),
    'outEggsNote': FormControl<String>(disabled: true),
    'incom_feed': FormControl<int>(
        value: 0, validators: [Validators.required, Validators.number]),
    'intak_feed':
        FormControl<double>(value: 0.0, validators: [Validators.required]),
    'death': FormControl<int>(value: 0, validators: [Validators.number]),
    /* 'incomTrays': FormControl<int>(value: 0, validators: [Validators.number]),
    'incomCartoons':
        FormControl<int>(value: 0, validators: [Validators.number]),*/
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size?.width ?? double.nan;
    //form.value = {inputFormControl.prodDate.name: prodDate};
    print(size);
    // print(prodDate);
    return Scaffold(
      appBar: appBar(context, 'العمليات اليومية في العنبر'),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Consumer(builder: (context, WidgetRef ref, child) {
                  final currentStep = ref.watch(resetStepperProvider);
                  return Stepper(
                    elevation: 5.0,
                    // stepIconBuilder: (stepIndex, stepState) {
                    //   if (stepState == StepState.complete)
                    //     return Stack(fit: StackFit.expand, children: [
                    //       Icon(
                    //         Icons.add_box_rounded,
                    //         size: 40.0,
                    //         opticalSize: 40,
                    //         color: Color.fromARGB(255, 224, 25, 11),
                    //       ),
                    //     ]);
                    // },
                    type: StepperType.vertical,
                    currentStep: currentStep,
                    controlsBuilder: (context, details) => Row(
                      textDirection: TextDirection.rtl,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        //if it is the last step hide continue button
                        if (currentStep ==
                            getSteps(currentStep, form, context, prodDate)
                                    .length -
                                1)
                          const SizedBox()
                        else
                          ReactiveForm(
                            formGroup: form,
                            child: ReactiveValueListenableBuilder(
                              formControlName: inputFormControl.amber_id.name,
                              builder: (context, control, __) {
                                // if there is amber selected show the next button
                                //else show the message
                                if (control.value != -1) {
                                  return StepNextButton(
                                    onPressed: details.onStepContinue,
                                    label: 'التالي',
                                  );
                                } else {
                                  return Padding(
                                    padding: const EdgeInsets.only(top: 2.0),
                                    child: Text(
                                      "من فضلك قم بتحديد رقم العنبر",
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall,
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                        const SizedBox(
                          width: 20.0,
                        ),
                        // if this is the first step hide the continue button
                        if (currentStep == 0)
                          const SizedBox()
                        else
                          StepNextButton(
                            onPressed: details.onStepCancel,
                            label: 'رجــــوع',
                          ),
                      ],
                    ),
                    onStepCancel: () => currentStep == 0
                        ? ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                            content: Text('لا توجد خطوة قبل هذه'),
                          ))
                        : setState(() {
                            ref.read(resetStepperProvider.notifier).state--;
                          }),
                    onStepContinue: () {
                      bool isLastStep = (currentStep ==
                          getSteps(currentStep, form, context, prodDate)
                                  .length -
                              1);
                      if (isLastStep) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('لقدوصلت للنهاية لا تنسى الحفظ'),
                          ),
                        );
                      } else {
                        //setState(() {
                        ref.read(resetStepperProvider.notifier).state++;
                        //});
                      }
                    },
                    onStepTapped: (step) => {
                      if (currentStep != 0)
                        setState(() {
                          ref.read(resetStepperProvider.notifier).state = step;
                        })
                      else
                        {}
                    },
                    steps: getSteps(currentStep, form, context, prodDate),
                  );
                }),
              )
            ]),
          ),
        ),
      ),
    );
  }
}

List<Step> getSteps(
    int currentStep, FormGroup form, BuildContext context, DateTime prodDate) {
  //final amberCont =
  form.control(inputFormControl.prodDate.name).value = prodDate;
  return <Step>[
    //Step1 get the list of Ambers from database and show it in Dropbox
    Step(
      state: currentStep > 0 ? StepState.complete : StepState.indexed,
      isActive: currentStep >= 0,
      title: const Text("حدد رقم العنبر"),
      content: Container(
        width: 150.0,
        height: 60,
        decoration: BoxDecoration(
          border: Border.all(width: 0.5, color: Theme.of(context).primaryColor),
          borderRadius: BorderRadius.circular(5),
        ),
        child: ReactiveForm(
          formGroup: form,
          child: Consumer(
            builder: (_, WidgetRef ref, __) {
              final amberMap = ref.watch(fetchAmbersProvider);
              //print(amberMap.asData?.value);
              return amberMap.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (err, stack) => Text('خطأ: $err'),
                data: (data) => ReactiveDropdownField(
                  formControlName: inputFormControl.amber_id.name,
                  dropdownColor: const Color.fromARGB(255, 235, 237, 240),
                  borderRadius: BorderRadius.circular(15),
                  elevation: 10,
                  decoration: customeInputDecoration(context, 'حدد رقم العنبر'),
                  alignment: AlignmentDirectional.bottomEnd,
                  onChanged: (control) => {
                    _resetForm(form, control.value),
                    // form.resetState({
                    //   // inputFormControl.prodDate.name:
                    //   //     ControlState(value:inputFormControl.prodDate.name),

                    //   inputFormControl.incom_feed.name: ControlState(value: 0),
                    //   inputFormControl.intak_feed.name:
                    //       ControlState(value: 0.0),
                    //   inputFormControl.prodTray.name: ControlState(value: 0),
                    //   inputFormControl.prodCarton.name: ControlState(value: 0),
                    //   inputFormControl.outTray.name: ControlState(value: 0),
                    //   inputFormControl.outCarton.name: ControlState(value: 0),
                    //   inputFormControl.death.name: ControlState(value: 0),
                    //   inputFormControl.outEggsNote.name:
                    //       ControlState(value: '', disabled: true),
                    // }),
                  },
                  //get the list of ambers and convert it into dropdown men item list
                  items: data.map<DropdownMenuItem<int>>((ambData) {
                    return DropdownMenuItem<int>(
                      value: ambData.id,
                      child: Text('${ambData.id} عنبر'),
                    );
                  }).toList(),
                ),
              );
            },
          ),
        ),
      ),
    ),
    //step 2 to insert feeds and death
    Step(
      state: currentStep > 2 ? StepState.complete : StepState.indexed,
      isActive: currentStep >= 2,
      title: const Text("  حركة العلف والدجاج"),
      content: _inputFeed(form, context),
    ),
    //step 3 to insert production of eggs and out eggs and save
    Step(
      state: currentStep > 3 ? StepState.complete : StepState.indexed,
      isActive: currentStep >= 3,
      title: const Text("حركة البيض"),
      content: _iputProductionEggs(form, context),
    ),
  ];
}

_iputProductionEggs(FormGroup form, BuildContext context) {
  // AmberController _controller = Get.put(AmberController());
  return ReactiveForm(
    formGroup: form,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 5.0),
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            color: const Color(0xFFF1F4F8),
            shape: BoxShape.rectangle,
          ),
          child: Text(' حركة البيض ',
              style: Theme.of(context).textTheme.headlineMedium),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              textDirection: TextDirection.rtl,
              children: <Widget>[
                Container(
                  width: 75.0,
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border.all(
                        width: 0.5, color: Theme.of(context).primaryColor),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: InputWidget(
                    form: form,
                    name: inputFormControl.prodTray,
                    labelText: 'الانتاج طبق',
                    next: inputFormControl.prodCarton,
                    keyboardType: const TextInputType.numberWithOptions(
                        signed: false, decimal: true),
                    validationMessages: {
                      'pattern': (error) => 'اكبر من 11',
                      'number': (error) => 'قيمة رقمية',
                      'required': (error) => 'مطلوب'
                    },
                  ),
                ),
                Container(
                  width: 75.0,
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border.all(
                        width: 0.5, color: Theme.of(context).primaryColor),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: InputWidget(
                    form: form,
                    name: inputFormControl.prodCarton,
                    labelText: 'الانتاج كرتون',
                    next: inputFormControl.outTray,
                    validationMessages: {
                      'number': (error) => 'فقط أرقام',
                      'required': (error) => 'مطلوب'
                    },
                    keyboardType: const TextInputType.numberWithOptions(
                        signed: false, decimal: true),
                  ),
                ),
                Container(
                  width: 75.0,
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border.all(
                        width: 0.5, color: Theme.of(context).primaryColor),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: InputWidget(
                    form: form,
                    name: inputFormControl.outTray,
                    labelText: 'الخارج طبق',
                    next: inputFormControl.outCarton,
                    validationMessages: {
                      'pattern': (error) => ' اكبر من12',
                      'number': (error) => 'قيمة رقمية',
                      'required': (error) => 'مطلوب'
                    },
                    keyboardType: const TextInputType.numberWithOptions(
                        signed: false, decimal: false),
                  ),
                ),
                Container(
                  width: 75.0,
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border.all(
                        width: 0.5, color: Theme.of(context).primaryColor),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: InputWidget(
                    form: form,
                    name: inputFormControl.outCarton,
                    labelText: 'الخارج كرتون',
                    next: inputFormControl.outEggsNote,
                    validationMessages: {
                      'number': (error) => 'فقط ارقام',
                      'required': (error) => 'مطلوب'
                    },
                    keyboardType: const TextInputType.numberWithOptions(
                        signed: false, decimal: false),
                  ),
                ),
              ]),
        ),
        Container(
          // height: MediaQuery.of(context).size.height * 2.5,
          color: kInputTextColor,
          child: ReactiveTextField(
            formControlName: 'outEggsNote',
            //expands: true,
            maxLines: 2,
            minLines: 1,
            decoration: customeInputDecoration(context, 'تفاصيل البيض الخارج'),
            textDirection: TextDirection.rtl,
            validationMessages: {'required': (error) => 'وضح مع من الخارج'},
          ),
        ),
        Container(
          margin: const EdgeInsets.all(10.0),
          width: 150.0,
          height: 40,
          color: kInputTextColor,
          child: SaveButton(),
        ),
      ],
    ),
  );
}

void _resetForm(FormGroup form, int? amberID) {
  form.resetState({
    inputFormControl.amber_id.name: ControlState(value: amberID),
    inputFormControl.incom_feed.name: ControlState(value: 0),
    inputFormControl.death.name: ControlState(value: 0),
    inputFormControl.intak_feed.name: ControlState(value: 0.0),
    inputFormControl.prodTray.name: ControlState(value: 0),
    inputFormControl.prodCarton.name: ControlState(value: 0),
    inputFormControl.outTray.name: ControlState(value: 0),
    inputFormControl.outCarton.name: ControlState(value: 0),
    inputFormControl.outEggsNote.name: ControlState(value: '', disabled: true),
  });
}

// class InputFeeds extends StatelessWidget {
//   const InputFeeds({
//     super.key,
//     required this.form,
//   });

//   final FormGroup form;

//   @override
//   Widget build(BuildContext context) {
_inputFeed(FormGroup form, BuildContext context) {
  return ReactiveForm(
    formGroup: form,
    child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      // ReactiveStatusListenableBuilder(
      //     formControlName: inputFormControl.incom_feed.name,
      //     builder: (_, control, __) => InputDecorator(
      //           decoration: InputDecoration(
      //             border: InputBorder.none,
      //             // label: SnackBar(
      //             //     content:
      //             //         Text('قيمة رقمية في حالة لا توجد قيمة أدخل صفر')),
      //             errorText: control.invalid
      //                 ? 'قيمة رقمية في حالة لا توجد قيمة أدخل صفر'
      //                 : null,
      //           ),
      //         )),
      Container(
        //margin: const EdgeInsets.only(bottom: 5.0),
        //: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: const Color(0xFFF1F4F8),
          shape: BoxShape.rectangle,
        ),
        child: Text(' حركة العلف ',
            style: Theme.of(context).textTheme.headlineMedium),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            textDirection: TextDirection.rtl,
            children: <Widget>[
              Container(
                width: 80.0,
                height: 60,
                //color: kInputTextColor,
                decoration: BoxDecoration(
                  border: Border.all(
                      width: 0.5, color: Theme.of(context).primaryColor),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: InputWidget(
                  form: form,
                  name: inputFormControl.death,
                  labelText: "الوفيات",
                  keyboardType: const TextInputType.numberWithOptions(
                      signed: false, decimal: false),
                  next: inputFormControl.incom_feed,
                  validationMessages: {
                    'number': (error) => 'قيمة رقمية',
                    'required': (error) => 'مطلوب'
                  },
                ),
              ),
              Container(
                width: 80.0,
                height: 60,
                decoration: BoxDecoration(
                  border: Border.all(
                      width: 0.5, color: Theme.of(context).primaryColor),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: InputWidget(
                    form: form,
                    name: inputFormControl.incom_feed,
                    labelText: 'العلف الوارد',
                    next: inputFormControl.intak_feed,
                    validationMessages: {
                      'number': (error) => 'قيمة رقمية',
                      'required': (error) => 'مطلوب',
                    },
                    keyboardType: const TextInputType.numberWithOptions(
                        signed: false, decimal: false)),
              ),
              Container(
                width: 80.0,
                height: 60,
                decoration: BoxDecoration(
                  border: Border.all(
                      width: 0.5, color: Theme.of(context).primaryColor),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: InputWidget(
                  form: form,
                  name: inputFormControl.intak_feed,
                  labelText: 'المستهلك',
                  next: inputFormControl.prodTray,
                  validationMessages: {
                    'required': (error) => 'مطلوب',
                    //'number': (error) => 'قيمة رقمية',
                  },
                  keyboardType: const TextInputType.numberWithOptions(
                      signed: false, decimal: true),
                ),
              ),
              //ReactiveTextField(
              //formControlName: inputFormControl.intak_feed.name,
              //   keyboardType: const TextInputType.numberWithOptions(
              //       signed: false, decimal: true),
              //   //textInputAction: TextInputAction.next,
              //   onTap: (FormControl<double> control) {
              //     control.reset();
              //   },
              //   decoration: InputDecoration(
              //     label: Text('العلف المستهلك',
              //         style: Theme.of(context).textTheme.bodyMedium),
              //     fillColor: Colors.white54,
              //     filled: true,
              //     border: const OutlineInputBorder(
              //         borderRadius: BorderRadius.all(Radius.circular(5.0))),
              //   ),
              //   textDirection: TextDirection.rtl,
              //   validationMessages: {
              //     'required': (error) => 'لايجب ان يكون فارغا',
              //   },
              // ),
            ]),
      ),
    ]),
  );
}

class InputWidget extends StatelessWidget {
  const InputWidget(
      {super.key,
      required this.form, //the formGroup name where this control be
      required this.name, //name of the formControl
      required this.labelText,
      required this.keyboardType,
      required this.next, //next Form control after this
      required this.validationMessages});
  final FormGroup form;
  final inputFormControl name;
  final String labelText;
  final inputFormControl next;
  final TextInputType keyboardType;
  final Map<String, String Function(Object?)> validationMessages;
  @override
  Widget build(BuildContext context) {
    return ReactiveTextField(
      formControlName: name.name,
      autofillHints: const {'فقط أرقام ', 'إذا لم توجد بيانات اكتب صفر'},
      textInputAction: TextInputAction.next,
      onTap: (FormControl<dynamic> control) {
        control.reset(updateParent: true);
      },
      // showErrors: (control) =>
      //     control.invalid &&
      //     control.dirty &&
      //     control.touched &&
      //     control.hasFocus &&
      //     control.hasErrors,
      onSubmitted: (FormControl<dynamic> control) => form.focus(next.name),
      decoration: customeInputDecoration(context, labelText),
      //if the current input is outTray or outCartoon enable the outEggNote field in the form
      onChanged: name.name == inputFormControl.outTray.name ||
              name.name == inputFormControl.outCarton.name
          ? (FormControl<dynamic> control) {
              if (control.value == 0 || control.value == null) {
                form.control('outEggsNote').markAsDisabled();
              } else {
                form.control('outEggsNote').markAsEnabled();
                form
                    .control('outEggsNote')
                    .setValidators([Validators.required], autoValidate: true);
              }
            }
          : (FormControl<dynamic> control) {
              form.markAllAsTouched();
              if (control.status == ControlStatus.invalid) {
                form.control(name.name).errors;
                //control.focus()
                print('error in ${form.control(name.name).errors}');
                ScaffoldMessenger.of(context).showSnackBar(mySnackBar(
                    context, 'قيمة رقمية في حالة لا توجد قيمة أدخل صفر'));
              }
            },
      textDirection: TextDirection.rtl,
      keyboardType: keyboardType,
      validationMessages: validationMessages,
      //     )),
      // child: Align(
      //   child: Text('hhhh'),
    );
  }
}

// child: Tooltip(
// message: 'ادخل الاطباق الوارد بالطبق',
// triggerMode: TooltipTriggerMode.tap,
// showDuration: Duration(seconds: 3),
// waitDuration: Duration(milliseconds: 100),
// textStyle: TextStyle(
// backgroundColor: Colors.black45,
// color: Colors.white,
// fontSize: 10.0,
// ),

/*// Automatic FlutterFlow imports
import 'dart:js';

import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

Future<dynamic> newCustomAction(ContextBuilder context) async {
  // create a form widget with 4  input textfield and submit button
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Create a new custom action"),
        content: Container(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: "tray",
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: "Description",
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: "Icon URL",
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: "Action URL",
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            child: Text("Cancel"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          ElevatedButton(
            child: Text("Create"),
            onPressed: () {
              // TODO: Implement action creation logic
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
*/