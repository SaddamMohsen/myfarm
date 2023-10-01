//import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_file.dart';
import 'package:intl/intl.dart';
import 'package:myfarm/features/production/domain/dailydata.dart';
//import 'package:myfarm/myfarm_theme.dart';
//import 'package:myfarm/routes.dart';
import 'package:myfarm/features/production/presentation/add_production_page.dart';
import 'package:myfarm/features/production/presentation/dailydata_view.dart';
import 'package:myfarm/utilities/constants.dart';

// import 'package:intl/date_symbol_data_local.dart';
import 'package:myfarm/widgets/my_button.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
//import 'package:flutter_animate/flutter_animate.dart';

import 'package:easy_date_timeline/easy_date_timeline.dart';
import '../features/production/data/supabase_amber_repository.dart';
import '../features/production/presentation/add_production_provider.dart';
//import '../widgets/add_button.dart';
import 'dart:io';
// final dailyProvider = Provider((ref) => SupabaseAmbersRepository());
// final amberProvider = FutureProvider.autoDispose
//     .family<List<DailyDataModel>, DateTime>((ref, prodDate) async {
//   final repository = ref.watch(dailyProvider);
//   return repository.getProductionData(prodDate: prodDate, ambId: 1);
// });

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String localDate = DateTime.now().toIso8601String();
  DateTime _selectedDate = DateTime.now();
  //final controller = DatePickerController();

  //final snackController = GetS

  @override
  initState() {
    super.initState();
    // print('in init state');
    getArabDate();
  }

//initializing the Intl library for get the current date in Arabic
  Future<void> getArabDate() async {
    //initialize the Date into Arabic locals
    //await local_date.initializeDateFormatting('ar', '');
    // String defaultLocal = Platform.localeName;

    // print(defaultLocal);
    // defaultLocal = Intl.canonicalizedLocale(defaultLocal);
    // print(defaultLocal);
    var format, dateString;
    try {
      format = DateFormat("yMMMMEEEEd", 'ar');
      dateString = format.format(DateTime.now().toLocal());
      _selectedDate = DateTime.now();
      setState(() {
        _selectedDate = DateTime.now();
        localDate = dateString;
      });
    } catch (e) {
      throw e;
      //print(e.toString());
    }
    //Specified the formate of date
    // var format = await DateFormat("yMMMMEEEEd", 'ar');
    // var dateString = format.format(DateTime.now().toLocal());

    // _selectedDate = DateTime.now();
    // format = DateFormat.yMd('en');

    // setState(() {
    //   _selectedDate = DateTime.now();
    //   localDate = dateString;
    // });
  }

  @override
  Widget build(BuildContext context) {
    // _selectedDate = DateTime.now();
    //final dailydata = ref
    // WidgetsBinding.instance.addPostFrameCallback((_) => controller
    //     .animateToDate(_selectedDate.subtract(const Duration(days: 2))));
    return Scaffold(
      // appBar: appBar(context, widget.title),
      // 3
      body: SafeArea(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _addBar(context, localDate),
              Container(
                color: Theme.of(context).scaffoldBackgroundColor,

                /*child: DatePicker(

                    controller: controller,
                    //subtract the current day from date.now to get the first day in month
                    DateTime.now()
                        .subtract(Duration(days: DateTime.now().day - 1)),
                    initialSelectedDate: DateTime.now(),
                    //activeDates: [DateTime.now()],
                    height: 100.0,
                    width: 80.0,
                    //get the number of days in this month to make it the last month
                    daysCount: DateTime(
                            DateTime.now().year, DateTime.now().month + 1, 0)
                        .day,
                    selectionColor: Theme.of(context).primaryColor,
                    selectedTextColor: Colors.white,
                    locale: "ar_AR",
                    onDateChange: (date) async {
                      setState(() {
                        _selectedDate = date;
                        // var format = DateFormat("EEE : d - MM - yyyy", 'ar');
                        var format = DateFormat('yMMMMEEEEd', 'ar');
                        var dateString = format.format(date);
                        localDate = dateString;
                      });
                    },
                  ),*/
                child: EasyDateTimeLine(
                  initialDate: DateTime.now(),
                  locale: "ar_AR",
                  onDateChange: (date) async {
                    setState(() {
                      _selectedDate = date;
                      // var format = DateFormat("EEE : d - MM - yyyy", 'ar');
                      var format = DateFormat('yMMMMEEEEd', 'ar');
                      var dateString = format.format(date);
                      localDate = dateString;
                    });
                  },
                  headerProps: const EasyHeaderProps(
                      monthPickerType: MonthPickerType.switcher,
                      selectedDateStyle: TextStyle(
                          fontFamily: 'Tajawal-ExtraBold',
                          fontSize: 14,
                          fontWeight: FontWeight.w800),
                      //monthStyle: ,
                      selectedDateFormat:
                          SelectedDateFormat.fullDateDayAsStrMY),
                  dayProps: EasyDayProps(
                    height: 70,
                    width: 60,
                    dayStructure: DayStructure.dayStrDayNumMonth,
                    todayStyle: DayStyle(
                      decoration: BoxDecoration(
                        color: Theme.of(context).focusColor,
                        border: Border.all(
                          color: Theme.of(context).disabledColor,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      monthStrStyle: Theme.of(context).textTheme.bodySmall,
                      dayNumStyle: Theme.of(context).textTheme.bodySmall,
                      dayStrStyle: Theme.of(context).textTheme.bodySmall,
                    ),
                    inactiveDayStyle: DayStyle(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomRight,
                          //tileMode: TileMode.decal,
                          colors: [
                            Color.fromARGB(255, 210, 218, 235),
                            Color.fromARGB(255, 248, 248, 248),
                          ],
                        ),
                        //color: Theme.of(context).cardColor,
                        border: Border.all(
                          color: Theme.of(context).dialogBackgroundColor,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      monthStrStyle: Theme.of(context).textTheme.bodySmall,
                      dayNumStyle:
                          Theme.of(context).textTheme.bodySmall?.copyWith(
                                fontSize: 14,
                              ),
                      dayStrStyle: Theme.of(context).textTheme.bodySmall,
                    ),
                    activeDayStyle: DayStyle(
                      monthStrStyle:
                          Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: Color.fromARGB(255, 17, 17, 17),
                              ),
                      dayNumStyle:
                          Theme.of(context).textTheme.bodySmall?.copyWith(
                                fontSize: 16,
                              ),
                      dayStrStyle: Theme.of(context).textTheme.bodyMedium,
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                        border: Border.all(color: Colors.red, width: 1),
                        //shape: BoxShape.circle,
                        // color: Color.fromARGB(255, 190, 19, 19),

                        // gradient: const LinearGradient(
                        //   begin: Alignment.topCenter,
                        //   end: Alignment.bottomCenter,
                        //   tileMode: TileMode.mirror,
                        //   colors: [
                        //     Color.fromARGB(158, 220, 224, 233),
                        //     Color(0xffE5EBDC),
                        //   ],
                        // ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  height: MediaQuery.of(context).size.width * 0.9,
                  width: MediaQuery.of(context).size.height * 0.9,
                  padding: const EdgeInsets.only(top: 10),
                  child: Consumer(builder: (_, WidgetRef ref, context) {
                    final dailydata = ref.watch(
                        FetchProductionDataProvider(todayDate: _selectedDate));
                    return dailydata.when(
                      loading: () => const Center(
                        child: SizedBox(
                          width: 100.0,
                          height: 100.0,
                          child: CircularProgressIndicator(),
                        ),
                      ),
                      error: (err, stack) => Text('Error: $err'),
                      data: (data) => data.isNotEmpty
                          ? DailyDataView(data: data)
                          : SizedBox(
                              child:
                                  Center(child: Text('لاتوجد بيانات لعرضها')),
                            ),
                      // ListView.builder(
                      //     itemCount: data.length,
                      //     itemBuilder: (context, index) {
                      //       return ListTile(
                      //         title: Text('${data[index]}'),
                      //       );
                      //     }),
                    );
                  }),
                ),
              ),
              //   //_dailyDataView(),
              /* SizedBox.expand(
                child: AddButton(),
              ),*/
              // ),
            ]),
      ),
    );
  }
}

//the main app bar it recieve the context and title of the app
// _dailyDataView() {
//   //final AmberController _controller = Get.put(AmberController());
//   return GetBuilder<AmberController>(
//     builder: (controller) => ListView.builder(
//         itemCount: controller.todayData.length,
//         itemBuilder: (context, index) {
//           print('in dailyData');
//           print(controller.todayData.length.toString());
//           return ListTile(
//             title: Text(' ${controller.todayData[index]}'),
//           );
//         }),
//   );
// }

//second bar that contains the date and adding button
_addBar(BuildContext context, String localDate) {
  //String date = localDate.toString();
  final DateTime date = DateFormat('yMMMMEEEEd', 'ar').parseUTC(localDate);
  return Container(
    width: MediaQuery.of(context).size.width * 0.9,
    padding: EdgeInsets.fromViewPadding(
        View.of(context).viewPadding, MediaQuery.of(context).devicePixelRatio),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                '  $localDate م',
                style: Theme.of(context).textTheme.headlineMedium?.merge(
                    const TextStyle(
                        fontFamily: 'Tajawal-ExtraBold',
                        fontSize: 14,
                        fontWeight: FontWeight.w800)),
              ),
            ),
          ],
        ),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: MyButton(
                lable: 'إضافة الانتاج +',
                onTap: () => {
                      // print(localDate),

                      if (date.isAfter(DateTime.now()))
                        ScaffoldMessenger.of(context).showSnackBar(mySnackBar(
                            context,
                            "لا يمكنك أدخال أنتاج بتاريخ أكبر من تاريخ اليوم"))
                      else
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  AddProduction(prodDate: date)),
                        ).onError((error, stackTrace) =>
                            debugPrint(error.toString())),
                    })),
      ],
    ),
  );
}
