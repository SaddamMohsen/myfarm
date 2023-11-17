import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  const MyButton({Key? key, required this.lable, required this.onTap})
      : super(key: key);
  final String lable;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      // style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
      //         backgroundColor: MaterialStatePropertyAll(
      //       Theme.of(context).colorScheme.primaryContainer,
      //     ) //.withRed(200)),
      // ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          // padding: EdgeInsets.all(10.0),
          height: 40,
          width: 100,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Theme.of(context).colorScheme.onSecondary
              //.withRed(200), //.withRed(200),
              ),
          child: ElevatedButton(
            onPressed: onTap,
            style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
                    backgroundColor: MaterialStatePropertyAll(
                  Theme.of(context).colorScheme.onSecondary, //.withRed(100),
                )),
            child: Text(lable,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: Colors.black)
                // .headlineMedium
                // ?.merge(TextStyle(color: Colors.white))),
                ),
          ),
        ),
      ),
    );
  }
}