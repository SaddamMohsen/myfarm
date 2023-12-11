import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myfarm/bootstrap.dart';

//  import 'package:firebase_core/firebase_core.dart';
//  import 'firebase_options.dart';

import 'package:myfarm/config/myfarm_theme.dart';
import 'package:myfarm/config/flexcolor_theme.dart';
import 'package:myfarm/config/routes.dart';

void main() async {
  /* WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );*/
  //enitializeintl Package local Date to Arabic

  // initializeDateFormatting("ar_SA", null);

  runApp(UncontrolledProviderScope(
      container: await bootstrap(),
      child: const ProviderScope(child: MyfarmApp())));
}

class MyfarmApp extends StatelessWidget {
  const MyfarmApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'مزرعتي',
      locale: const Locale('ar_SA'),
      themeMode: ThemeMode.system,
      theme: FlexColorFarmTheme.lightTheme,
      darkTheme: FlexColorFarmTheme.darkTheme,

// If you do not have a themeMode switch, uncomment this line
// to let the device system mode control the theme mode:
//themeMode: ThemeMode.system,

      //theme: MyFarmTheme.lightTheme,
      //darkTheme: MyFarmTheme.darktTheme,

      // home: const MyHomePage(
      //   title: 'مزرعتي',
      // ),
      onGenerateRoute: RouteGenerator.generateRoute,
      initialRoute: RouteGenerator.splashPage,
      /*getPages: [
        GetPage(
            name: RouteGenerator.loginPage,
            page: () => LoginPage(),
            // binding: AmberBinding(),
            transition: Transition.circularReveal),
       ],*/
      debugShowCheckedModeBanner: false,
    );
  }
}
