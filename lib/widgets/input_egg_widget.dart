

import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../utilities/constants.dart';
import 'input_widget.dart';
import 'package:myfarm/utilities/form_model.dart';

import 'my_save_button.dart';
class InputEggWidget extends StatelessWidget {
  const InputEggWidget({
    super.key,
    required  this.form
  });
  final FormGroup form;
  @override
  Widget build(BuildContext context) {
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
                          signed: false, decimal:false),
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
              style: Theme.of(context).textTheme.bodySmall,
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
            child: SaveButton(type:"save"),
          ),
        ],
      ),
    );
  }
}