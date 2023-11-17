// ignore_for_file: constant_identifier_names, camel_case_types

import 'package:reactive_forms/reactive_forms.dart';

import 'constants.dart';

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
