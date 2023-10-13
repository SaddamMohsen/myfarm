import 'package:flutter/material.dart';

import '../routes.dart';

const Color kIconColor = Color.fromARGB(255, 63, 137, 248);
const double kIconSize = 40.0;
const Color kInputTextColor =
    Color(0xffF3F6FC); //Color.fromARGB(255, 253, 251, 251);
const kTrayNumberPattern = r'^([0-9]|1[01])$';

//appBar method
appBar(BuildContext context, String title) {
  return AppBar(
    titleSpacing: 10.0,
    leading: IconButton(
      icon: const Icon(
        Icons.navigate_before_rounded,
        color: kIconColor,
        size: kIconSize,
      ),
      onPressed: () => {
        Navigator.pop(context),
        // Get.toNamed(RouteGenerator.homePage, arguments: {'title': 'مزرعتي'}),
      },
      color: Theme.of(context).primaryColor,
    ),
    title: Center(
      child: Text(
        title,
        style: Theme.of(context).textTheme.headlineMedium,
        //textDirection: TextDirection.RTL,
      ),
    ),
    actions: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: IconButton(
          icon: const Icon(
            Icons.account_circle,
            color: kIconColor,
            size: kIconSize,
          ),
          tooltip: '',
          onPressed: () => {},
        ),
      ),
    ],
  );
}

//SnackBar for messages
SnackBar mySnackBar(BuildContext context, String message) {
  // print(message);
  return SnackBar(
    duration: Duration(seconds: 3),
    content: Column(children: [
      const Icon(
        Icons.warning_amber_outlined,
        color: Colors.red,
      ),
      const SizedBox(
        height: 10,
      ),
      Text(
        message,
        textAlign: TextAlign.center,
        // style: Theme.of(context).textTheme.titleSmall?.copyWith(
        //       color: Color.fromARGB(255, 255, 255, 255),
        //     ),
      ),
    ]),
  );
}

//Decoration of the Input of profuction Form fields
InputDecoration customeInputDecoration(BuildContext context, String label) {
  return InputDecoration(
    label: Text(label, style: Theme.of(context).textTheme.bodySmall),
    fillColor: Colors.white54,
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: const BorderSide(color: Colors.red, width: 1.0),
    ),
    filled: true,
  );
}
