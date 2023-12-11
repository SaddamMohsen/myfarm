import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputNumber extends StatefulWidget {
  const InputNumber({super.key, required this.labelText, required this.controller});
  final String labelText;
  final TextEditingController controller;

  @override
  State<InputNumber> createState() => _InputNumberState();
}

class _InputNumberState extends State<InputNumber> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: AlignmentDirectional.center,
      width: 60.0,
      height: 80.0,
      //padding: const EdgeInsets.all(10.0),
      child: TextField(
        controller: widget.controller,
        keyboardType: const TextInputType.numberWithOptions(
            signed: false, decimal: false),
        textInputAction: TextInputAction.next,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        decoration: InputDecoration(
          labelText: widget.labelText,
          fillColor: Theme.of(context).colorScheme.onTertiary, //Colors.white54,
          filled: true,
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0))),
        ),
        textDirection: TextDirection.rtl,
        onChanged: (value) => {
          //print(widget.controller.value),
        },
      ),
    );
  }
}
