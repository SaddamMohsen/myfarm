import 'package:flutter/material.dart';
import 'package:myfarm/features/production/domain/dailydata.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:myfarm/utilities/form_model.dart';
import 'package:myfarm/widgets/input_widget.dart';

import '../utilities/constants.dart';
import 'my_save_button.dart';
class MyEditDialog extends StatefulWidget {
   MyEditDialog({super.key, required this.title, required this.content});
  final String title;
  final DailyDataModel content;

  @override
  State<MyEditDialog> createState() => _MyEditDialogState();
}

class _MyEditDialogState extends State<MyEditDialog> {
  late FormGroup myForm;

  @override
  void initState() {
    super.initState();
    myForm = form;
    myForm
        .control(inputFormControl.incom_feed.name)
        .value = widget.content.incomFeed;
    myForm
        .control(inputFormControl.intak_feed.name)
        .value = widget.content.intakFeed;
    myForm
        .control(inputFormControl.death.name)
        .value = widget.content.death;
    myForm
        .control(inputFormControl.prodTray.name)
        .value = widget.content.prodTray;
    myForm
        .control(inputFormControl.prodCarton.name)
        .value = widget.content.prodCarton;
    myForm
        .control(inputFormControl.prodDate.name)
        .value = widget.content.prodDate;
    myForm
        .control(inputFormControl.amber_id.name)
        .value = widget.content.amberId;
    myForm
        .control(inputFormControl.outTray.name)
        .value = widget.content.outEggsTray;
    myForm
        .control(inputFormControl.outCarton.name)
        .value = widget.content.outEggsCarton;
    myForm
        .control(inputFormControl.outEggsNote.name)
        .value = widget.content.outEggsNote;
  }

  @override
  Widget build(BuildContext context) {
    //convert string to list
    print(widget.content.toString());

    return SingleChildScrollView(
      child: AlertDialog(
        icon:  Icon(
          Icons.edit_note_outlined,
          color: Theme.of(context).colorScheme.primary,
          size: 60.0,
        ),
        backgroundColor: const Color(0xffF3F6FC),
        elevation: 15.0,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(32.0))),
        // shape: Border.all(
        //     width: 0.5, color: Theme.of(context).colorScheme.onBackground),
        title: Text(widget.title, style: Theme.of(context).textTheme.headlineSmall),
        content: Container(
          height:MediaQuery.of(context).size.height*0.4,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Theme.of(context).cardColor,
          ),
          child: Card(
            //elevation: 2,
            child:Column(
      children:[
        _inputFeed(myForm, context),
            _iputProductionEggs(myForm, context,widget.content.trId),

            ]),
          ),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
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
_iputProductionEggs(FormGroup form, BuildContext context,int? rowId) {
  // AmberController _controller = Get.put(AmberController());
  return SingleChildScrollView(
    child: ReactiveForm(
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
            padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 3.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                textDirection: TextDirection.rtl,
                children: <Widget>[
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
                    width: 60.0,
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
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w200
              ),
              decoration: customeInputDecoration(context, 'تفاصيل البيض الخارج'),
              textDirection: TextDirection.rtl,
              validationMessages: {'required': (error) => 'وضح مع من الخارج'},
            ),
          ),
          Container(
            margin: const EdgeInsets.all(5.0),
            width: 100.0,
            height: 30,
            color: kInputTextColor,
            child: SaveButton(type:"update",rowId:rowId??0),
          ),
        ],
      ),
    ),
  );
}