import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../../utilities/constants.dart';
import '../../../production/presentation/widgets/input_widget.dart';
import 'package:myfarm/utilities/form_model.dart';

import 'my_save_button.dart';

// ignore: must_be_immutable
class InputEggWidget extends StatelessWidget {
  InputEggWidget({super.key, required this.form, this.trid = 0});
  final FormGroup form;
  //row id used in update to send it to save button
  int trid;
  @override
  Widget build(BuildContext context) {
    // print(' row number $trid    here we gooo');
    return ReactiveForm(
      formGroup: form,
      child: Wrap(
        //mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 5.0),
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              // color: Theme.of(context)
              //     .colorScheme
              //     .onBackground, // const Color(0xFFF1F4F8),
              shape: BoxShape.rectangle,
            ),
            child: Text(' حركة البيض ',
                style: Theme.of(context).textTheme.headlineMedium),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                textDirection: TextDirection.rtl,
                children: <Widget>[
                  Container(
                    width: 70.0,
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
                          signed: false, decimal: false),
                      validationMessages: {
                        'pattern': (error) => 'اكبر من 11',
                        'number': (error) => 'قيمة رقمية',
                        'required': (error) => 'مطلوب'
                      },
                    ),
                  ),
                  Container(
                    width: 70.0,
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
                  /* Container(
                    width: 60.0,
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
                    width: 60.0,
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
                  ),*/
                ]),
          ),
          /*Container(
            // height: MediaQuery.of(context).size.height * 2.5,
            color: kInputTextColor,
            child: ReactiveTextField(
              formControlName: 'outEggsNote',
              //expands: true,
              maxLines: 2,
              minLines: 1,
              style: Theme.of(context).textTheme.bodySmall,
              decoration:
                  customeInputDecoration(context, 'تفاصيل البيض الخارج'),
              textDirection: TextDirection.rtl,
              validationMessages: {'required': (error) => 'وضح مع من الخارج'},
            ),
          ),
          */
          Center(
            child: Container(
              margin: const EdgeInsets.all(10.0),
              width: 150.0,
              height: 40,
              //color: kInputTextColor,
              child: trid == 0
                  ? const SaveButton(type: "save")
                  : SaveButton(type: "update", rowId: trid),
            ),
          ),
        ],
      ),
    );
  }
}
