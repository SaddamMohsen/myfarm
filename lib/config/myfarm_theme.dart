// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';

class MyFarmTheme {
  static ThemeData get lightTheme {
    //1
    return ThemeData(
        //2
        brightness: Brightness.light,
        // backgroundColor: Color.fromARGB(187, 45, 39, 201),
        primaryColor: const Color(0xFF6750A4),

        ///Color Scheme
        colorScheme: const ColorScheme(
          scrim: Color(0xff000000),
          primary: Color(0xFF6750A4),
          inversePrimary: Color(0xffEADDFF),
          onPrimary: Color(0xffFFFFFF),
          secondary: Color(0xffEADDFF),
          onSecondary: Color(0xff625B71),
          secondaryContainer: Color(0xff4A4458),
          onSecondaryContainer: Color(0xffE8DEF8),
          primaryContainer: Color(0xffEADDFF),
          onPrimaryContainer: Color(0xff7D5260),
          brightness: Brightness.light,
          background: Color(0xff141218),
          onBackground: Color(0xffE6E0E9),
          surfaceVariant: Color(0xffE7E0EC),
          surface: Color(0xffFEF7FF),
          onSurface: Color(0xff1D1B20),
          onError: Color(0xffFAFAFA),
          error: Color(0xffB3261E),
          errorContainer: Color(0xff8C1D18),
          onErrorContainer: Color(0xffF9DEDC),
        ),
        /*colorScheme: const ColorScheme(
            brightness: Brightness.light,
            primary: Color(0xffb62400),
            onPrimary: Color(0xff02131),
            onError: Color(0xffFAFAFA),
            primaryContainer: Color(0xffffdad2),
            onPrimaryContainer: Color(0xff3d0600),
            secondary: Color.fromARGB(255, 39, 38, 38),
            onSecondary: Color(0xffffffff),
            secondaryContainer: Color(0xffffdad2),
            onSecondaryContainer: Color(0xff2c1510),
            tertiary: Color(0xff6d5d2e),
            onTertiary: Color(0xffffffff),
            tertiaryContainer: Color(0xfff8e1a6),
            onTertiaryContainer: Color(0xff241a00),
            error: Color(0xffba1a1a),
            errorContainer: Color(0xffffdad6),
            onErrorContainer: Color(0xff410002),
            background: Color(0xfffffbff),
            onBackground: Color(0xff201a19),
            surface: Color(0xfffffbff),
            onSurface: Color(0xff201a19),
            surfaceVariant: Color(0xfff5ddd8),
            onSurfaceVariant: Color(0xff534340),
            outline: Color(0xff85736f),
            outlineVariant: Color(0xffd8c2bd),
            inverseSurface: Color(0xff362f2d),
            onInverseSurface: Color(0xfffbeeeb),
            inversePrimary: Color(0xffffb4a3),
            surfaceTint: Color(0xffb62400),
            ),*/
        //Color(0xffFAFAFA),
        cardColor: const Color(0xffFAFAFA),
        dialogBackgroundColor: const Color(0xffF3F6FC),
        disabledColor: const Color.fromARGB(255, 204, 216, 240),
        dividerColor: Color.fromARGB(255, 157, 183, 236),
        scaffoldBackgroundColor: const Color(0xffFAFAFA),
        //const Color(0xffF6F4EF),
        //Color(0xffF3F6FC), // Color(0xffFAFAFA),
        fontFamily: 'Tajawal',
        //3
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
            minWidth: 80,
            height: 50,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0)),
            buttonColor: const Color.fromARGB(255, 227, 221, 231),
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
            fontSize: 14.0,
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
            textBaseline: TextBaseline.ideographic,
          ),
        ),
        snackBarTheme: SnackBarThemeData(
          contentTextStyle: const TextStyle(
            color: Colors.black,
            fontFamily: 'Tajawal',
            fontSize: 12.0,
            fontWeight: FontWeight.w200,
          ),
          backgroundColor: const Color.fromARGB(255, 236, 234, 234),
          elevation: 10.0,
          shape: Border.all(
            //width: 1,
            style: BorderStyle.none,
          ),
          behavior: SnackBarBehavior.floating,
        ),
        dropdownMenuTheme: DropdownMenuThemeData(
            menuStyle: MenuStyle(
          alignment: AlignmentDirectional.bottomStart,
          backgroundColor: const MaterialStatePropertyAll<Color>(
            const Color(0xffF3F6FC),
          ),
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
        dataTableTheme: DataTableThemeData(
          headingRowColor: MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states) {
            if (states.contains(MaterialState.hovered)) {
              return Color(0xffE6E0E9);
            }
            return null;
          }),
          headingTextStyle: const TextStyle(
            color: Colors.black,
            fontFamily: 'Tajawal',
            fontSize: 14.0,
            fontWeight: FontWeight.w700,
          ),
          decoration: BoxDecoration(
              color: Colors.amberAccent,
              border: Border.all(
                  color: const Color.fromARGB(255, 45, 53, 53),
                  width: 2,
                  style: BorderStyle.solid)),
          dataTextStyle: const TextStyle(
            color: Colors.black,
            fontFamily: 'Tajawal',
            fontSize: 14.0,
            fontWeight: FontWeight.w500,
          ),
          //     MaterialStateTextStyle.resolveWith((Set<MaterialState> states) {
          //   if (states.contains(MaterialState.dragged))
          //     return const TextStyle(
          //       color: Colors.black,
          //       fontFamily: 'Tajawal',
          //       fontSize: 14.0,
          //       fontWeight: FontWeight.w700,
          //     );
          //   return const TextStyle(
          //     color: Colors.black,
          //     fontFamily: 'Tajawal',
          //     fontSize: 14.0,
          //     fontWeight: FontWeight.w700,
          //   );
          // }),
          dataRowColor:
              MaterialStateColor.resolveWith((Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed)) return Colors.black54;
            return const Color.fromARGB(31, 226, 193, 193);
          }),
        ),
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

  static ThemeData get darktTheme {
    return ThemeData(
        //2
        brightness: Brightness.dark,
        colorScheme: const ColorScheme(
          brightness: Brightness.dark,
          primary: Color(0xffb62400),
          onPrimary: Color(0xff02131),
          onError: Color(0xffFAFAFA),
          primaryContainer: Color(0xffffdad2),
          onPrimaryContainer: Color(0xff3d0600),
          secondary: Color.fromARGB(255, 39, 38, 38),
          onSecondary: Color.fromARGB(255, 37, 37, 37),
          secondaryContainer: Color(0xffffdad2),
          onSecondaryContainer: Color(0xff2c1510),
          tertiary: Color(0xff6d5d2e),
          onTertiary: Color(0xffffffff),
          tertiaryContainer: Color(0xfff8e1a6),
          onTertiaryContainer: Color(0xff241a00),
          error: Color(0xffba1a1a),
          errorContainer: Color(0xffffdad6),
          onErrorContainer: Color(0xff410002),
          background: Color.fromARGB(255, 29, 28, 29),
          onBackground: Color(0xff201a19),
          surface: Color.fromARGB(255, 58, 40, 58),
          onSurface: Color(0xff201a19),
          surfaceVariant: Color(0xfff5ddd8),
          onSurfaceVariant: Color(0xff534340),
          outline: Color(0xff85736f),
          outlineVariant: Color(0xffd8c2bd),
          inverseSurface: Color(0xff362f2d),
          onInverseSurface: Color(0xfffbeeeb),
          inversePrimary: Color(0xffffb4a3),
          surfaceTint: Color(0xffb62400),
        ),
        // backgroundColor: Color.fromARGB(187, 45, 39, 201),
        primaryColor: const Color(0xffc0b5f5),
        //colorSchemeSeed: Color(0xffFAFAFA),
        cardColor: Color.fromARGB(255, 83, 72, 72),
        dialogBackgroundColor: Color.fromARGB(255, 31, 35, 44),
        scaffoldBackgroundColor: Color.fromARGB(255, 26, 20, 20),
        //const Color(0xffF6F4EF),
        //Color(0xffF3F6FC), // Color(0xffFAFAFA),
        fontFamily: 'Tajawal',
        //3
        appBarTheme: const AppBarTheme(
          foregroundColor: Color(0xffFAFAFA),
          backgroundColor: Colors.black,
        ),
        iconButtonTheme: IconButtonThemeData(
            style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
              const Color.fromARGB(255, 189, 180, 180)),
        )),
        buttonTheme: ButtonThemeData(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0)),
            buttonColor: const Color.fromARGB(255, 227, 221, 231),
            disabledColor: const Color(0xFFF6F8FA)),
        inputDecorationTheme: const InputDecorationTheme(
          activeIndicatorBorder:
              BorderSide(color: Color(0xFFF6F8FA), width: 0.2),
          //RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: 5,topRight: 5))
        ),
        textTheme: const TextTheme(
          headlineMedium: TextStyle(
            color: Color.fromARGB(255, 250, 248, 248),
            fontFamily: 'Tajawal',
            fontSize: 14.0,
            fontWeight: FontWeight.w700,
          ),
          headlineSmall: TextStyle(
            color: Colors.white,
            fontFamily: 'Tajawal',
            fontSize: 10.0,
            fontWeight: FontWeight.w200,
          ),
          bodyMedium: TextStyle(
            color: Colors.white,
            fontFamily: 'Tajawal',
            fontSize: 12.0,
            fontWeight: FontWeight.w700,
          ),
          bodySmall: TextStyle(
            color: Colors.white,
            fontFamily: 'Tajawal',
            fontSize: 10.0,
            fontWeight: FontWeight.w200,
            decoration: TextDecoration.underline,
          ),
        ),
        snackBarTheme: SnackBarThemeData(
          contentTextStyle: const TextStyle(
            color: Colors.white,
            fontFamily: 'Tajawal',
            fontSize: 12.0,
            fontWeight: FontWeight.w200,
          ),
          backgroundColor: const Color.fromARGB(255, 236, 234, 234),
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
              return Color.fromARGB(255, 62, 49, 77);

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