import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myfarm/models/dailydata.dart';
//import 'package:flutter/services.dart';
//import 'package:myfarm/models/dailydata.dart';
import 'package:myfarm/routes.dart';
import 'package:myfarm/utilities/constants.dart';
import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';
//import 'package:myfarm/models/dailydata.dart';

class AddProduction extends StatefulWidget {
  AddProduction({Key? key}) : super(key: key);

  @override
  State<AddProduction> createState() => _AddProductionState();
}

class _AddProductionState extends State<AddProduction> {
  DailyDataModel? todayData;
  int currentStep = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  final form = FormGroup({
    'amberId': FormControl<int>(value: -1),
    'prodDate': FormControl<DateTime>(value: DateTime.now()),
    // 'eggs': FormGroup({
    'prodTray': FormControl<int>(
      value: 0,
      validators: [Validators.number, Validators.pattern(kTrayNumberPattern)],
    ),
    'prodCarton': FormControl<int>(value: 0, validators: [Validators.number]),
    'outEggsTray': FormControl<int>(
        value: 0, validators: [Validators.pattern(kTrayNumberPattern)]),
    'outEggsCarton':
        FormControl<int>(value: 0, validators: [Validators.number]),
    'outEggsNote': FormControl<String>(disabled: true),
    'incomeFeed': FormControl<int>(value: 0, validators: [Validators.number]),
    'intakFeed': FormControl<double>(validators: [Validators.required]),
    // 'death': FormControl<int>(value: 0, validators: [Validators.number]),
    //'incomTrays': FormControl<int>(value: 0, validators: [Validators.number]),
    //'incomCartoons': FormControl<int>(value: 0, validators: [Validators.number]),
  });

  @override
  Widget build(BuildContext context) {
    // final note = form.control('outEggsNote');
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: _appBar(context, 'العمليات اليومية في العنبر'),
      body: SingleChildScrollView(
        child: Center(
          heightFactor: 0.9,
          child: Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Column(children: [
              // DropdownButton(items: items, onChanged: onChanged)
              Text(
                'العمليات اليومية في العنبر',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Stepper(
                margin: const EdgeInsets.only(left: 25.0, right: 15.0),
                type: StepperType.vertical,
                currentStep: currentStep,
                controlsBuilder: (context, details) => Row(
                  textDirection: TextDirection.rtl,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    //if it is the last step hide continue button
                    ReactiveForm(
                      formGroup: form,
                      child: ReactiveValueListenableBuilder(
                        formControlName: 'amberId',
                        builder: (context, control, __) {
                          details.currentStep ==
                                  getSteps(currentStep, form, context).length -
                                      1
                              ? const Text('hhh')
                              : form.control('amberId').value == -1
                                  ? const Text('من فضلك حدد العنبر')
                                  : ElevatedButton(
                                      style: Theme.of(context)
                                          .elevatedButtonTheme
                                          .style,
                                      onPressed: details.onStepContinue,
                                      child: const Text('متابعة الادخال'),
                                    );
                          return MyNextButton(
                            onPressed: details.onStepContinue,
                            label: 'التالي',
                          );
                        },
                        child: ElevatedButton(
                          style: Theme.of(context).elevatedButtonTheme.style,
                          onPressed: details.onStepContinue,
                          child: const Text('متابعة الادخال'),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20.0,
                    ),
                    ElevatedButton(
                      style: Theme.of(context)
                          .elevatedButtonTheme
                          .style
                          ?.copyWith(
                              backgroundColor: MaterialStateColor.resolveWith(
                        (states) {
                          if (states.contains(MaterialState.pressed) ||
                              states.contains(MaterialState.focused))
                            return const Color.fromARGB(255, 151, 135, 135);
                          else
                            return Color.fromARGB(255, 233, 231, 235);
                        },
                      )),
                      onPressed: details.onStepCancel,
                      child: const Text('الغاء '),
                    ),
                  ],
                ),
                onStepCancel: () => currentStep == 0
                    ? ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('لا توجد خطوة قبل هذه'),
                      ))
                    : setState(() {
                        currentStep -= 1;
                      }),
                onStepContinue: () {
                  bool isLastStep = (currentStep ==
                      getSteps(currentStep, form, context).length - 1);
                  if (isLastStep) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('لقدوصلت للنهاية لا تنسى الحفظ'),
                      ),
                    );
                    print(Get.arguments);
                  } else {
                    setState(() {
                      currentStep += 1;
                    });
                  }
                },
                onStepTapped: (step) => setState(() {
                  currentStep = step;
                }),
                steps: getSteps(currentStep, form, context),
              )
            ]),
          ),
        ),
      ),
    );
  }
}

class MyNextButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String label;
  const MyNextButton({super.key, this.onPressed, required this.label});
  @override
  Widget build(BuildContext context) {
    final form = ReactiveForm.of(context);
    return ElevatedButton(
        child: const Text(label),
        // ignore: invalid_use_of_protected_member
        onPressed:
            form?.findControl('amberId')?.value != -1 ? onPressed : null);
  }

  /*void _onPressed() {
    print('Hello Reactive Forms!!!');
  }*/
}

List<Step> getSteps(int currentStep, FormGroup form, BuildContext context) {
  return <Step>[
    Step(
      state: currentStep > 0 ? StepState.complete : StepState.indexed,
      isActive: currentStep >= 0,
      title: const Text("حدد رقم العنبر"),
      content: SizedBox(
        width: 150.0,
        child: ReactiveForm(
          formGroup: form,
          child: ReactiveDropdownField(
            decoration: InputDecoration(
              label: Text('حدد رقم العنبر',
                  style: Theme.of(context).textTheme.bodySmall),
              fillColor: Colors.white54,
              filled: true,
              border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5.0))),
            ),
            alignment: AlignmentDirectional.bottomEnd,
            onChanged: (control) => {
              print(control.value),
            },
            formControlName: 'amberId',
            items: const [
              DropdownMenuItem(
                // alignment: AlignmentDirectional.centerEnd,
                value: 1,
                child: Text("عنبر رقم1"),
              ),
              DropdownMenuItem(
                value: 2,
                child: Text("عنبر رقم2"),
              ),
              DropdownMenuItem(
                value: 3,
                child: Text("عنبر رقم3"),
              ),
            ],
          ),
        ),
      ),
    ),
    Step(
      state: currentStep > 2 ? StepState.complete : StepState.indexed,
      isActive: currentStep >= 2,
      title: const Text("حركة العلف"),
      content: _inputFeed(form, context),
    ),
    Step(
      state: currentStep > 3 ? StepState.complete : StepState.indexed,
      isActive: currentStep >= 3,
      title: const Text("حركة البيض"),
      content: _iputProductionEggs(form, context),
    ),
  ];
}

_iputProductionEggs(FormGroup form, BuildContext context) {
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
                  color: kInputTextColor,
                  child: ReactiveTextField(
                    formControlName: 'prodTray',
                    textInputAction: TextInputAction.next,
                    onTap: (FormControl<int> control) {
                      control.reset();
                    },
                    onSubmitted: (FormControl<int> control) =>
                        form.focus('prodCarton'),
                    textDirection: TextDirection.rtl,
                    keyboardType: const TextInputType.numberWithOptions(
                        signed: false, decimal: false),
                    validationMessages: {'pattern': (error) => 'اكبر من 11'},
                    decoration: InputDecoration(
                      label: Text('الانتاج طبق',
                          style: Theme.of(context).textTheme.bodyMedium),
                      fillColor: Colors.white54,
                      filled: true,
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.0))),
                    ),
                  ),
                ),
                Container(
                  width: 75.0,
                  height: 50,
                  color: kInputTextColor,
                  child: ReactiveTextField(
                    formControlName: 'prodCarton',
                    keyboardType: const TextInputType.numberWithOptions(
                        signed: false, decimal: false),
                    textInputAction: TextInputAction.next,
                    onTap: (FormControl<int> control) {
                      control.reset();
                    },
                    onSubmitted: (Control) => form.focus('outEggsTray'),
                    decoration: InputDecoration(
                      label: Text('الانتاج كرتون',
                          style: Theme.of(context).textTheme.bodyMedium),
                      fillColor: Colors.white54,
                      filled: true,
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.0))),
                    ),
                    textDirection: TextDirection.rtl,
                    validationMessages: {
                      'prodCarton': (error) => 'لايجب ان يكون فارغا',
                      'number': (error) => 'فقط ارقام'
                    },
                  ),
                ),
                Container(
                  width: 75.0,
                  height: 50,
                  color: kInputTextColor,
                  child: ReactiveTextField(
                    formControlName: 'outEggsTray',
                    textInputAction: TextInputAction.next,
                    onTap: (FormControl<int> control) {
                      control.reset();
                    },
                    onChanged: (FormControl<int> control) {
                      if (control.value == 0 || control.value == null) {
                        return;
                      } else {
                        form.control('outEggsNote').markAsEnabled();
                        form.control('outEggsNote').setValidators(
                            [Validators.required],
                            autoValidate: true);
                        //form.markAsTouched();
                      }

                      // note.focus()
                    },
                    onSubmitted: (control) => form.focus('outEggsCarton'),
                    decoration: InputDecoration(
                      label: Text('الخارج طبق',
                          style: Theme.of(context).textTheme.bodyMedium),
                      fillColor: Colors.white54,
                      filled: true,
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.0))),
                    ),
                    textDirection: TextDirection.rtl,
                    keyboardType: const TextInputType.numberWithOptions(
                        signed: false, decimal: false),
                    validationMessages: {'pattern': (error) => ' اكبر من11'},
                  ),
                ),
                Container(
                  width: 75.0,
                  height: 50,
                  color: kInputTextColor,
                  child: ReactiveTextField(
                    formControlName: 'outEggsCarton',
                    textInputAction: TextInputAction.next,
                    onChanged: (FormControl<int> control) {
                      if (control.value == 0 || control.value == null) {
                        return;
                      } else {
                        form.control('outEggsNote').markAsEnabled();
                        form.control('outEggsNote').setValidators(
                            [Validators.required],
                            autoValidate: true);
                        // form.markAsTouched();
                      }
                    },
                    onTap: (FormControl<int> control) {
                      control.reset();
                    },
                    onSubmitted: (Control) => form.focus('outEggsNote'),
                    decoration: InputDecoration(
                      label: Text('الخارج كرتون',
                          style: Theme.of(context).textTheme.bodyMedium),
                      fillColor: Colors.white54,
                      filled: true,
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.0))),
                    ),
                    textDirection: TextDirection.rtl,
                    keyboardType: const TextInputType.numberWithOptions(
                        signed: false, decimal: false),
                    validationMessages: {'number': (error) => 'فقط ارقام'},
                  ),
                ),
              ]),
        ),
        Container(
          // height: MediaQuery.of(context).size.height * 2.5,
          color: kInputTextColor,
          child: ReactiveTextField(
            formControlName: 'outEggsNote',
            decoration: InputDecoration(
              label: Text('تفاصيل البيض الخارج',
                  style: Theme.of(context).textTheme.bodySmall),
              hintText: 'تفاصيل البيض الخارج',
              fillColor: Colors.white54,
              filled: true,
              // enabled: false,
              border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5.0))),
            ),
            textDirection: TextDirection.rtl,
            validationMessages: {'required': (error) => 'وضح مع من الخارج'},
          ),
        ),
        Container(
          margin: EdgeInsets.all(10.0),
          width: 150.0,
          height: 40,
          color: kInputTextColor,
          child: ReactiveFormConsumer(
              // stream: null,
              builder: (context, form, child) {
            return ElevatedButton(
              style: Theme.of(context).elevatedButtonTheme.style,
              onPressed: () {
                //print(child);
                form.markAsTouched();
                if (form.invalid) {
                  print('هناك خطأ');
                  //print(form.value);
                  // mark al children as touched so errors will show up
                  //form.markAsTouched()
                } else {
                  print(form.value);
                  DailyDataModel todayData =
                      DailyDataModel.fromJson(form.value);

                  //print(todayData);
                }
              },
              child: Text(
                'حفظ البيانات',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            );
          }),
        ),
      ],
    ),
  );
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
                color: kInputTextColor,
                child: ReactiveTextField(
                  formControlName: 'incomeFeed',
                  textInputAction: TextInputAction.next,
                  onTap: (FormControl<int> control) {
                    control.reset(updateParent: true);
                  },
                  onSubmitted: (FormControl<int> control) =>
                      form.focus('intakFeed'),
                  decoration: InputDecoration(
                    label: Text('العلف الوارد',
                        style: Theme.of(context).textTheme.bodyMedium),
                    fillColor: Colors.white54,
                    filled: true,
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0))),
                  ),
                  textDirection: TextDirection.rtl,
                  keyboardType: const TextInputType.numberWithOptions(
                      signed: false, decimal: false),
                  validationMessages: {
                    'number': (error) => 'عدد الوارد بالكيس'
                  },
                ),
              ),
              Container(
                width: 80.0,
                height: 60,
                color: kInputTextColor,
                child: ReactiveTextField(
                  formControlName: 'intakFeed',
                  keyboardType: const TextInputType.numberWithOptions(
                      signed: false, decimal: true),
                  //textInputAction: TextInputAction.next,
                  onTap: (FormControl<double> control) {
                    control.reset();
                  },
                  decoration: InputDecoration(
                    label: Text('العلف المستهلك',
                        style: Theme.of(context).textTheme.bodyMedium),
                    fillColor: Colors.white54,
                    filled: true,
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0))),
                  ),
                  textDirection: TextDirection.rtl,
                  validationMessages: {
                    'required': (error) => 'لايجب ان يكون فارغا',
                  },
                ),
              ),
            ]),
      ),
    ]),
  );
}

class InputNumber extends StatelessWidget {
  const InputNumber({super.key, required this.labelText});
  final String labelText;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: AlignmentDirectional.center,
      width: 60.0,
      height: 100.0,
      //padding: const EdgeInsets.all(10.0),
      child: TextField(
        keyboardType:
            TextInputType.numberWithOptions(signed: false, decimal: false),
        inputFormatters: [],
        decoration: InputDecoration(
          labelText: labelText,
          fillColor: Colors.white54,
          filled: true,
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0))),
        ),
        textDirection: TextDirection.rtl,
        onChanged: (value) => {
          print(value),
        },
      ),
    );
  }
}

_appBar(BuildContext context, String title) {
  return AppBar(
    titleSpacing: 10.0,
    leading: IconButton(
      icon: const Icon(
        Icons.navigate_before_rounded,
        color: kIconColor,
        size: kIconSize,
      ),
      onPressed: () => {
        Get.toNamed(RouteGenerator.homePage, arguments: {title: 'مزرعتي'}),
      },
      color: Theme.of(context).primaryColor,
    ),
    title: Text(
      title,
      style: Theme.of(context).textTheme.headlineMedium,
      //textDirection: TextDirection.RTL,
    ),
    actions: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: IconButton(
          icon: const Icon(
            Icons.account_circle,
            color: kIconColor,
            size: kIconSize,
          ),
          tooltip: '',
          onPressed: () => {},
        ),
      ),
    ],
  );
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