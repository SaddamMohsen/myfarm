import 'package:flutter/material.dart';

const Color kIconColor = Color.fromARGB(255, 63, 137, 248);
const double kIconSize = 40.0;
const Color kInputTextColor =
    Color(0xffF3F6FC); //Color.fromARGB(255, 253, 251, 251);
///allowing number from 1 to 11 because tray more than 11 is carton
const kTrayNumberPattern = r'^([0-9]|1[01])$';

//report type
enum reportType { monthly, daily, amberMonthly }

//NETWORK STATUS
enum NetworkStatus { NotDetermined, On, Off }

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
    elevation: 7,
    behavior: SnackBarBehavior.fixed,
    duration: const Duration(seconds: 2),
    content: Column(children: [
      Icon(Icons.warning_amber_outlined,
          color: Theme.of(context).colorScheme.error),
      const SizedBox(
        height: 10,
      ),
      Text(
        message,
        textAlign: TextAlign.center,
      ),
    ]),
  );
}

//Decoration of the Input of profuction Form fields
InputDecoration customeInputDecoration(BuildContext context, String label) {
  return InputDecoration(
    label: Text(label, style: Theme.of(context).textTheme.bodySmall),
    fillColor: Theme.of(context).colorScheme.surface.withAlpha(200),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(3),
      borderSide:
          BorderSide(color: Theme.of(context).colorScheme.error, width: 1.0),
    ),
    filled: true,
  );
}
