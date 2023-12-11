import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

class FlexColorFarmTheme {
  //FlexColorScheme
  static ThemeData get lightTheme {
    //1
    return FlexThemeData.light(
      scheme: FlexScheme.blueM3,
      surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
      blendLevel: 9,
      tabBarStyle: FlexTabBarStyle.forBackground,
      subThemesData: const FlexSubThemesData(
        blendOnLevel: 10,
        blendOnColors: false,
        //elevatedButtonSchemeColor: SchemeColor.onPrimary,
        elevatedButtonSecondarySchemeColor: SchemeColor.inversePrimary,
        outlinedButtonOutlineSchemeColor: SchemeColor.secondaryContainer,
        fabUseShape: true,
        dialogBackgroundSchemeColor: SchemeColor.inversePrimary,
        tabBarItemSchemeColor: SchemeColor.primary,
        tabBarIndicatorSchemeColor: SchemeColor.tertiary,
      ),
      visualDensity: FlexColorScheme.comfortablePlatformDensity,
      useMaterial3: true,
      swapLegacyOnMaterial3: true,
      // To use the playground font, add GoogleFonts package and uncomment
      fontFamily: 'Tajawal',
      textTheme: const TextTheme(
        headlineMedium: TextStyle(
          //color: Colors.black,
          fontFamily: 'Tajawal',
          fontSize: 14.0,
          fontWeight: FontWeight.w700,
        ),
        headlineSmall: TextStyle(
          //color: Colors.black,
          fontFamily: 'Tajawal',
          fontSize: 14.0,
          fontWeight: FontWeight.w200,
        ),
        bodyMedium: TextStyle(
          //color: Colors.black,
          fontFamily: 'Tajawal',
          fontSize: 12.0,
          fontWeight: FontWeight.w700,
        ),
        bodySmall: TextStyle(
          //color: Colors.black,
          fontFamily: 'Tajawal',
          fontSize: 10.0,
          fontWeight: FontWeight.w200,
          decoration: TextDecoration.underline,
          textBaseline: TextBaseline.ideographic,
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    return FlexThemeData.dark(
      scheme: FlexScheme.blueM3,
      surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
      blendLevel: 15,
      tabBarStyle: FlexTabBarStyle.forBackground,
      subThemesData: const FlexSubThemesData(
        blendOnLevel: 20,
        elevatedButtonSecondarySchemeColor: SchemeColor.inversePrimary,
        outlinedButtonOutlineSchemeColor: SchemeColor.secondaryContainer,
        fabUseShape: true,
        fabAlwaysCircular: true,
        dialogBackgroundSchemeColor: SchemeColor.inversePrimary,
      ),
      visualDensity: FlexColorScheme.comfortablePlatformDensity,
      useMaterial3: true,
      swapLegacyOnMaterial3: true,
      // To use the Playground font, add GoogleFonts package and uncomment
      fontFamily: 'Tajawal',
      textTheme: const TextTheme(
        headlineMedium: TextStyle(
          //color: Colors.black,
          fontFamily: 'Tajawal',
          fontSize: 14.0,
          fontWeight: FontWeight.w700,
        ),
        headlineSmall: TextStyle(
          //color: Colors.black,
          fontFamily: 'Tajawal',
          fontSize: 14.0,
          fontWeight: FontWeight.w200,
        ),
        bodyMedium: TextStyle(
          //color: Colors.black,
          fontFamily: 'Tajawal',
          fontSize: 12.0,
          fontWeight: FontWeight.w700,
        ),
        bodySmall: TextStyle(
          //color: Colors.black,
          fontFamily: 'Tajawal',
          fontSize: 10.0,
          fontWeight: FontWeight.w200,
          decoration: TextDecoration.underline,
          textBaseline: TextBaseline.ideographic,
        ),
      ),
    );
  }
}
