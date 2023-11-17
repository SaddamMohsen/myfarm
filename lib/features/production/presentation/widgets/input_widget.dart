import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../../utilities/constants.dart';
import '../../../../utilities/form_model.dart';

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

      onSubmitted: (FormControl<dynamic> control) => form.focus(next.name),
      decoration: customeInputDecoration(context, labelText),
      //if the current input is outTray or outCartoon enable the outEggNote field in the form
      onChanged: name.name == inputFormControl.outTray.name ||
              name.name == inputFormControl.outCarton.name
          ? (FormControl<dynamic> control) {
              if ((form.control(inputFormControl.outTray.name).value == 0 ||
                      form.control(inputFormControl.outTray.name).value ==
                          null) &&
                  (form.control(inputFormControl.outCarton.name).value == 0 ||
                      form.control(inputFormControl.outCarton.name).value ==
                          null) &&
                  control.value == 0) {
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
                // print('error in ${form.control(name.name).errors}');
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
