import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  const MyButton({Key? key,required this.lable,required this.onTap}) : super(key: key);
  final String lable;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
         // padding: EdgeInsets.all(10.0),
          height: 50,
          width: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: Theme.of(context).primaryColor,
          ),
          child: Center(child: Text(lable,style:Theme.of(context).textTheme.headlineMedium?.merge(TextStyle(color: Colors.white)))),
        ),
      ),
    );
  }
}