import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class StepNextButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String label;

  StepNextButton({super.key, required this.onPressed, required this.label})
      : super();

  final MaterialStatesController elevBtnController = MaterialStatesController();
  @override
  Widget build(BuildContext context) {
    final form = ReactiveForm.of(context);
    return SizedBox(
      width: 100.0,
      child: ElevatedButton(
          statesController: elevBtnController,
          onPressed:
              // ignore: invalid_use_of_protected_member
              form?.findControl('amberId')?.value != -1 ? onPressed : null,
          style: Theme.of(context).elevatedButtonTheme.style,
          child: Text(label)),
    );
  }
}
