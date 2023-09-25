import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
//  import 'package:firebase_core/firebase_core.dart';
//  import 'firebase_options.dart';
//import 'package:myfarm/features/production/presentation/add_production_page.dart';
import 'package:myfarm/features/authentication/presentation/login_page.dart';
import 'package:myfarm/myfarm_theme.dart';
import 'package:myfarm/routes.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'apikey.dart';

void main() async {
  /* WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );*/
  try {
    await Supabase.initialize(
      url: supabase_url,
      anonKey: supabase_anonkey,
    );
  } catch (e) {
    print('error ${e.toString()}');
  }
  runApp(const ProviderScope(child: MyfarmApp()));
}

class MyfarmApp extends StatelessWidget {
  const MyfarmApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'مزرعتي',
      locale: const Locale('ar_Ar'),
      theme: MyFarmTheme.lightTheme,
      home: const LoginPage(),
      onGenerateRoute: RouteGenerator.generateRoute,
      initialRoute: RouteGenerator.loginPage,
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
