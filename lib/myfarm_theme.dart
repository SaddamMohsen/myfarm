// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';

class MyFarmTheme {
  static ThemeData get lightTheme {
    //1
    return ThemeData(
        //2
        brightness: Brightness.light,
        // backgroundColor: Color.fromARGB(187, 45, 39, 201),
        primaryColor: const Color(0xFF4a26fd),
        //colorSchemeSeed: Color(0xffFAFAFA),
        cardColor: const Color(0xffFAFAFA),
        dialogBackgroundColor: const Color(0xffF3F6FC),
        scaffoldBackgroundColor: Color(0xffFAFAFA), //const Color(0xffF6F4EF),
        //Color(0xffF3F6FC), // Color(0xffFAFAFA),
        fontFamily: 'Tajawal', //3
        appBarTheme: const AppBarTheme(
          foregroundColor: Colors.black,
          backgroundColor: Color(0xffFAFAFA),
        ),
        iconButtonTheme: IconButtonThemeData(
            style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
              const Color.fromARGB(255, 189, 180, 180)),
        )),
        buttonTheme: ButtonThemeData(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0)),
            buttonColor: Color.fromARGB(255, 227, 221, 231),
            disabledColor: const Color(0xFFF6F8FA)),
        inputDecorationTheme: const InputDecorationTheme(
          activeIndicatorBorder:
              BorderSide(color: Color(0xFFF6F8FA), width: 0.2),
          //RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: 5,topRight: 5))
        ),
        textTheme: const TextTheme(
          headlineMedium: TextStyle(
            color: Colors.black,
            fontFamily: 'Tajawal',
            fontSize: 14.0,
            fontWeight: FontWeight.w700,
          ),
          headlineSmall: TextStyle(
            color: Colors.black,
            fontFamily: 'Tajawal',
            fontSize: 10.0,
            fontWeight: FontWeight.w200,
          ),
          bodyMedium: TextStyle(
            color: Colors.black,
            fontFamily: 'Tajawal',
            fontSize: 12.0,
            fontWeight: FontWeight.w700,
          ),
          bodySmall: TextStyle(
            color: Colors.black,
            fontFamily: 'Tajawal',
            fontSize: 10.0,
            fontWeight: FontWeight.w200,
            decoration: TextDecoration.underline,
          ),
        ),
        snackBarTheme: SnackBarThemeData(
          contentTextStyle: const TextStyle(
            color: Colors.black,
            fontFamily: 'Tajawal',
            fontSize: 12.0,
            fontWeight: FontWeight.w200,
          ),
          backgroundColor: Color.fromARGB(255, 236, 234, 234),
          elevation: 10.0,
          shape: Border.all(
            //width: 1,
            style: BorderStyle.none,
          ),
          behavior: SnackBarBehavior.floating,
        ),
        dropdownMenuTheme: DropdownMenuThemeData(
            menuStyle: MenuStyle(
          alignment: AlignmentDirectional.bottomEnd,
          backgroundColor: const MaterialStatePropertyAll<Color>(
              Color.fromARGB(255, 124, 118, 129)),
          side:
              MaterialStateBorderSide.resolveWith((Set<MaterialState> states) {
            if (states.contains(MaterialState.selected) ||
                states.contains(MaterialState.hovered)) {
              return const BorderSide(
                  width: 2, color: Color.fromARGB(255, 116, 87, 85));
            }
            return const BorderSide(
                width: 2,
                style: BorderStyle.solid,
                color: Color.fromARGB(255, 59, 55,
                    55)); // Defer to default value on the theme or widget.
          }),
        )),
        // ignore: prefer_const_constructors
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
          elevation: const MaterialStatePropertyAll<double>(5.0),
          side:
              MaterialStateBorderSide.resolveWith((Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed) ||
                states.contains(MaterialState.hovered)) {
              return const BorderSide(color: Color.fromARGB(255, 56, 78, 207));
            } else if (states.contains(MaterialState.disabled))
              return const BorderSide(
                  color: Color.fromARGB(255, 229, 230, 231),
                  style: BorderStyle.solid);
            return null; // Defer to default value on the theme or widget.
          }),
          backgroundColor:
              MaterialStateColor.resolveWith((Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed))
              const Color.fromARGB(255, 83, 82, 83);
            else if (states.contains(MaterialState.hovered))
              const Color.fromARGB(255, 166, 163, 168);
            return const Color.fromARGB(255, 233, 231, 235);
          }),
          foregroundColor:
              MaterialStateColor.resolveWith((Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled))
              return const Color.fromARGB(255, 252, 251, 253);

            return const Color.fromARGB(255, 83, 82, 83);
          }),
          padding: MaterialStateProperty.all(const EdgeInsets.all(5.0)),
          mouseCursor: MaterialStateMouseCursor.clickable,
        )));
  }
}
// 1
/* static TextTheme lightTextTheme = TextTheme(
    bodyLarge: GoogleFonts.openSans(
      fontSize: 14.0,
      fontWeight: FontWeight.w700,
      color: Colors.black,
    ),
    displayLarge: GoogleFonts.openSans(
      fontSize: 32.0,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    displayMedium: GoogleFonts.openSans(
      fontSize: 21.0,
      fontWeight: FontWeight.w700,
      color: Colors.black,
    ),
    displaySmall: GoogleFonts.openSans(
      fontSize: 16.0,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
  );
}*/