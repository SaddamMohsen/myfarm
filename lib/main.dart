import 'package:flutter/material.dart';
import 'package:myfarm/myfarm_theme.dart';
import 'package:myfarm/routes.dart';
import 'package:myfarm/screens/home_page.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyfarmApp());
}

class MyfarmApp extends StatelessWidget {
  const MyfarmApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'مزرعتي',
      locale:const Locale('ar_Ar'),
      theme: MyFarmTheme.lightTheme,
      home: const MyHomePage(title: 'مزرعتي'),
      onGenerateRoute:RouteGenerator.generateRoute,
      debugShowCheckedModeBanner: false,
    );
  }
}