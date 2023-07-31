import 'package:flutter/material.dart';
import 'package:myfarm/myfarm_theme.dart';
import 'package:myfarm/routes.dart';
import 'package:myfarm/utilities/constants.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart' as local_date;
import 'package:myfarm/widgets/my_button.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String localDate = '';
  late DateTime _selectedDate;
  final controller = DatePickerController();

  @override
  initState() {
    super.initState();
    // print('in init state');
    getArabDate();
    WidgetsBinding.instance.addPostFrameCallback((_) =>
        controller.animateToDate(_selectedDate.subtract(Duration(days: 2))));
  }

//initializing the Intl library for get the current date in Arabic
  Future<void> getArabDate() async {
    await local_date.initializeDateFormatting('ar', null);
    var format = DateFormat.yMMMMEEEEd('ar');
    var dateString = format.format(DateTime.now());
    // format = DateFormat.yMd('en');

    setState(() {
      _selectedDate = DateTime.now();
      localDate = dateString;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context, widget.title),
      // 3
      body: SafeArea(
        child: Column(children: [
          _addBar(context, localDate),
          Container(
              color: Color.fromARGB(255, 228, 231, 235),
              child: DatePicker(
                controller: controller,
                //subtract the current day from date.now to get the first day in month
                DateTime.now().subtract(Duration(days: DateTime.now().day - 1)),
                initialSelectedDate: DateTime.now(),
                activeDates: [DateTime.now()],
                height: 100.0,
                width: 80.0,
                //get the number of days in this month to make it the last month
                daysCount:
                    DateTime(DateTime.now().year, DateTime.now().month + 1, 0)
                        .day,
                selectionColor: Theme.of(context).primaryColor,
                selectedTextColor: Colors.white,
                locale: "ar_AR",
                onDateChange: (date) {
                  // New date selected
                  //print(date);
                  setState(() {
                    _selectedDate = date;
                    print(_selectedDate);
                  });
                },
              ))
        ]),
      ),
    );
  }
}

//the main app bar it recieve the context and title of the app
_appBar(BuildContext context, String title) {
  return AppBar(
    titleSpacing: 10.0,
    leading: IconButton(
      icon: const Icon(
        Icons.navigate_before_rounded,
        color: kIconColor,
        size: kIconSize,
      ),
      onPressed: () => {},
      color: Theme.of(context).primaryColor,
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
          icon: const Icon(
            Icons.account_circle,
            color: kIconColor,
            size: kIconSize,
          ),
          tooltip: '',
          onPressed: () => {},
        ),
      ),
    ],
  );
}

//second bar that contains the date and adding button
_addBar(BuildContext context, String localDate) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              '$localDate',
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium
                  ?.merge(TextStyle(fontFamily: 'Marhey')),
            ),
          ),
        ],
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: MyButton(
            lable: 'إضافة الانتاج +',
            onTap: () => {
                  Get.toNamed(RouteGenerator.addProdPage,
                      arguments: {'localDate': localDate}),
                  print(localDate),
                }),
      ),
    ],
  );
}
