import 'package:flutter/material.dart';

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
        keyboardType: const TextInputType.numberWithOptions(
            signed: false, decimal: false),
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
