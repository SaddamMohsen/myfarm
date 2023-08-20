import 'package:flutter/material.dart';
import 'package:myfarm/myfarm_theme.dart';
import 'package:myfarm/routes.dart';
import 'package:myfarm/screens/add_production_binding.dart';
import 'package:myfarm/screens/home_page.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:myfarm/screens/add_production_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyfarmApp());
}

class MyfarmApp extends StatelessWidget {
  const MyfarmApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'مزرعتي',
      locale: const Locale('ar_Ar'),
      theme: MyFarmTheme.lightTheme,
      home: const MyHomePage(title: 'مزرعتي'),
      /*onGenerateRoute: RouteGenerator.generateRoute,*/
      getPages: [
        GetPage(
            name: RouteGenerator.homePage,
            page: () => MyHomePage(title: 'مزرعتي'),
            transition: Transition.zoom),
        GetPage(
            name: RouteGenerator.addProdPage,
            page: () => AddProduction(),
            binding: AmberBinding(),
            transition: Transition.zoom)
      ],
      debugShowCheckedModeBanner: false,
    );
  }
}
