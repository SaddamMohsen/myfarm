import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myfarm/features/authentication/application/supabase_auth_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../config/routes.dart';

const Color kIconColor = Color.fromARGB(255, 63, 137, 248);
const double kIconSize = 40.0;
const Color kInputTextColor =
    Color(0xffF3F6FC); //Color.fromARGB(255, 253, 251, 251);
const kTrayNumberPattern = r'^([0-9]|1[01])$';

//appBar method
appBar(BuildContext context, String title) {
  return AppBar(
    elevation: 0,
    surfaceTintColor: Theme.of(context).colorScheme.onBackground,
    titleSpacing: 10.0,
    leading: IconButton(
      icon: Icon(
        Icons.manage_search,
        color: Theme.of(context).colorScheme.primary,
        size: kIconSize,
      ),
      onPressed: () => {
        // Navigator.pop(context),
        // Get.toNamed(RouteGenerator.homePage, arguments: {'title': 'مزرعتي'}),
      },
      color: Theme.of(context).colorScheme.outline,
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
          tooltip: 'مزرعة رقم',
          icon: Icon(
            Icons.account_circle,
            color: Theme.of(context).colorScheme.primary,
            size: kIconSize,
          ),
          onPressed: () => {
            //print('hhh'),
            // Consumer(builder: (context, ref, child) {
            //   final User user = ref
            //       .read(authControllerProvider.notifier)
            //       .currentUser() as User;

            //   print(user);
            //   return Text(user?.userMetadata?['farm_id'].toString() ?? '');
            // }),
            // return Text('dd');
          },
        ),
      ),
    ],
  );
}

//SnackBar for messages
SnackBar mySnackBar(BuildContext context, String message) {
  // print(message);
  return SnackBar(
    behavior: SnackBarBehavior.fixed,
    duration: Duration(seconds: 2),
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
    fillColor: Theme.of(context).colorScheme.outline,
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide:
          BorderSide(color: Theme.of(context).colorScheme.primary, width: 1.0),
    ),
    filled: true,
  );
}
