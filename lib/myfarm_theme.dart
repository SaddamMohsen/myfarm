// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';

class MyFarmTheme {
  static ThemeData get lightTheme {
    //1
    return ThemeData(
        //2
        brightness: Brightness.light,
        primaryColor: const Color(0xD8140DEA),
        iconButtonTheme: IconButtonThemeData(
            style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.redAccent[300]),
        )),
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Tajawal', //3
        buttonTheme: ButtonThemeData(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0)),
            buttonColor: Color.fromARGB(255, 227, 221, 231),
            disabledColor: const Color(0xFFF6F8FA)),
        textTheme: const TextTheme(
          headlineMedium: TextStyle(
            color: Colors.black,
            fontFamily: 'Tajawal',
            fontSize: 14.0,
            fontWeight: FontWeight.w700,
          ),
          bodyMedium: TextStyle(
            color: Colors.black,
            fontFamily: 'Tajawal',
            fontSize: 14.0,
            fontWeight: FontWeight.w700,
          ),
          bodySmall: TextStyle(
            color: Colors.black,
            fontFamily: 'Tajawal',
            fontSize: 10.0,
            fontWeight: FontWeight.w300,
          ),
        ),
        appBarTheme: const AppBarTheme(
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
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