//import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:myfarm/features/authentication/application/supabase_auth_provider.dart';
import 'package:myfarm/features/home/application/fetch_production_data.dart';
import 'package:myfarm/features/home/presentation/widget/daily_data_table.dart';
import 'package:myfarm/features/production/application/add_production_notifier.dart';
import 'package:myfarm/features/production/domain/entities/dailydata.dart';

import 'package:myfarm/features/production/presentation/screen/add_production_page.dart';
import 'package:myfarm/features/report/presentation/report_screen.dart';
import 'package:myfarm/utilities/constants.dart';

import 'package:myfarm/features/common/presentation/widget/my_button.dart';

import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:myfarm/features/home/presentation/widget/out_dialog.dart';
import '../../../production/application/add_production_provider.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';

//import '../widgets/add_button.dart';
// final dailyProvider = Provider((ref) => SupabaseAmbersRepository());
// final amberProvider = FutureProvider.autoDispose
//     .family<List<DailyDataModel>, DateTime>((ref, prodDate) async {
//   final repository = ref.watch(dailyProvider);
//   return repository.getProductionData(prodDate: prodDate, ambId: 1);
// });

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  ConsumerState<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  String localDate = DateTime.now().toIso8601String();
  DateTime _selectedDate = DateTime.now();
  //final controller = DatePickerController();

  //final snackController = GetS

  @override
  initState() {
    super.initState();

    getArabDate();
  }

//initializing the Intl library for get the current date in Arabic
  Future<void> getArabDate() async {
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
      throw e.toString();
    }
  }

  ///function to exit the application
  Future<bool> _onWillPop() async {
    return await showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  icon: const Icon(Icons.logout_rounded),
                  title: const Text("تأكيد الخروج"),
                  content: const Text("هل تريد أغلاق التطبيق",
                      textAlign: TextAlign.center),
                  actions: [
                    Row(
                      // textDirection: TextDirection.LTR,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MyButton(
                            lable: 'نعم',
                            onTap: () {
                              Navigator.of(context).pop(true);

                              // return true;
                            }),
                        MyButton(
                            lable: 'لا',
                            onTap: () {
                              Navigator.of(context).pop(false);
                              //return false;
                              //
                            })
                      ],
                    ),
                  ],
                )) ??
        false;
    //print(isExit);
    //return true;
  }

  @override
  void didUpdateWidget(covariant MyHomePage oldWidget) {
    // TODO: implement didUpdateWidget
    print('updated');
    super.didUpdateWidget(oldWidget);
  }

  final _key = GlobalKey<ExpandableFabState>();
  @override
  Widget build(BuildContext context) {
    //ref.watch(FetchProductionDataProvider(todayDate: _selectedDate));
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
          appBar: appBar(context, widget.title),
          body: SafeArea(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // _addBar(context, localDate),
                  Container(
                    color: Theme.of(context).scaffoldBackgroundColor,
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
                          monthPickerType:
                              MonthPickerType.dropDown, //.switcher,
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
                            color: Theme.of(context).colorScheme.surface,
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
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomRight,
                              //tileMode: TileMode.decal,
                              colors: [
                                Theme.of(context).colorScheme.outline,
                                // Color.fromARGB(255, 210, 218, 235),
                                Theme.of(context).colorScheme.outlineVariant,
                                // Color.fromARGB(255, 248, 248, 248),
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
                          monthStrStyle: Theme.of(context).textTheme.bodyMedium,
                          // ?.copyWith(
                          //   color: const Color.fromARGB(255, 17, 17, 17),
                          // ),
                          dayNumStyle:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    fontSize: 16,
                                  ),
                          dayStrStyle: Theme.of(context).textTheme.bodyMedium,
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8)),
                            border: Border.all(color: Colors.red, width: 1),
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
                        // var newList = [];
                        final dailydata = ref.watch(fetchProductionDataProvider(
                            todayDate: _selectedDate));

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
                              ? MyDataTable(
                                  data: data) //DailyDataView(data: data)
                              : const SizedBox(
                                  child: Center(
                                      child: Text('لاتوجد بيانات لعرضها')),
                                ),
                        );
                      }),
                    ),
                  ),
                ]),
          ),

          ///extended fab buttons
          floatingActionButtonLocation: ExpandableFab.location,
          floatingActionButton: ExpandableFab(
            distance: 50,
            // fanAngle: 0,
            overlayStyle: ExpandableFabOverlayStyle(blur: 0.5),
            type: ExpandableFabType.up,
            key: _key,
            openButtonBuilder: RotateFloatingActionButtonBuilder(
              child: const Icon(
                Icons.add_box_rounded,
                size: 30,
              ),
              fabSize: ExpandableFabSize.regular,
              foregroundColor: Theme.of(context).colorScheme.onSurface,
              backgroundColor: Theme.of(context).colorScheme.surface,
              shape: const CircleBorder(),
            ),
            closeButtonBuilder: FloatingActionButtonBuilder(
              size: 1,
              builder: (BuildContext context, void Function()? onPressed,
                  Animation<double> progress) {
                return IconButton(
                  onPressed: onPressed,
                  icon: Icon(
                    Icons.close_fullscreen_sharp,
                    color: Theme.of(context).colorScheme.primary,
                    size: 40,
                  ),
                );
              },
            ),
            children: [
              ///button to navigate to add_production page
              ElevatedButton.icon(
                  onPressed: () {
                    if (_selectedDate.isAfter(DateTime.now())) {
                      ScaffoldMessenger.of(context).showSnackBar(mySnackBar(
                          context,
                          "لا يمكنك أدخال أنتاج بتاريخ أكبر من تاريخ اليوم"));
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                AddProduction(prodDate: _selectedDate)),
                      ).onError(
                          (error, stackTrace) => debugPrint(error.toString()));
                    }
                    final state = _key.currentState;
                    if (state != null) {
                      debugPrint('isOpen:${state.isOpen}');
                      state.toggle();
                    }
                  },
                  icon: const Icon(Icons.add_box_sharp),
                  label: const Text('اضافة الانتاج')),

              /// button to show report screen
              ElevatedButton.icon(
                  onPressed: () {
                    if (_selectedDate.isAfter(DateTime.now())) {
                      ScaffoldMessenger.of(context).showSnackBar(mySnackBar(
                          context,
                          "لا يمكنك عرض تقرير بتاريخ أكبر من تاريخ اليوم"));
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ReportScreen(repDate: _selectedDate)),
                      ).onError(
                          (error, stackTrace) => debugPrint(error.toString()));
                    }
                    final state = _key.currentState;
                    if (state != null) {
                      debugPrint('isOpen:${state.isOpen}');
                      state.toggle();
                    }
                  },
                  icon: const Icon(Icons.add_box_sharp),
                  label: const Text('عرض التقرير')),

              ///button for open out dialoge
              ElevatedButton.icon(
                  onPressed: () {
                    if (_selectedDate.isAfter(DateTime.now())) {
                      ScaffoldMessenger.of(context).showMaterialBanner(
                          MaterialBanner(
                              content: const Text(
                                  "لا يمكنك أضافة خارج بتاريخ أكبر من تاريخ اليوم"),
                              actions: [
                            Row(
                              children: [
                                ElevatedButton.icon(
                                    onPressed: () {
                                      // print('hhhh');
                                      ScaffoldMessenger.of(context)
                                          .clearMaterialBanners();
                                      // .hideCurrentMaterialBanner();
                                    },
                                    icon: const Icon(Icons.abc_outlined),
                                    label: const Text('اخفاء')),
                              ],
                            )
                          ]));
                      // ScaffoldMessenger.of(context).showSnackBar(mySnackBar(
                      //     context,
                      //     "لا يمكنك أضافة خارج بتاريخ أكبر من تاريخ اليوم"));
                    } else {
                      showDialog(
                          context: context,
                          builder: ((context) => MyOutDialog(
                                title: 'بيانات الخارج',
                                date: _selectedDate,
                                moveType: 'خارج',
                              )));
                      final state = _key.currentState;
                      if (state != null) {
                        debugPrint('isOpen:${state.isOpen}');
                        state.toggle();
                      }
                    }
                  },
                  icon: const Icon(Icons.outbond),
                  label: const Text('اضافة الخارج')),

// button for open in dialoge
              ElevatedButton.icon(
                  onPressed: () {
                    if (_selectedDate.isAfter(DateTime.now())) {
                      ScaffoldMessenger.of(context).showMaterialBanner(
                          MaterialBanner(
                              content: const Text(
                                  "لا يمكنك أضافة وارد بتاريخ أكبر من تاريخ اليوم"),
                              actions: [
                            Row(
                              children: [
                                ElevatedButton.icon(
                                    onPressed: () {
                                      // print('hhhh');
                                      ScaffoldMessenger.of(context)
                                          .clearMaterialBanners();
                                      // .hideCurrentMaterialBanner();
                                    },
                                    icon: const Icon(Icons.abc_outlined),
                                    label: const Text('اخفاء')),
                              ],
                            )
                          ]));
                      // ScaffoldMessenger.of(context).showSnackBar(mySnackBar(
                      //     context,
                      //     "لا يمكنك أضافة خارج بتاريخ أكبر من تاريخ اليوم"));
                    } else {
                      showDialog(
                          context: context,
                          builder: ((context) => MyOutDialog(
                                title: 'بيانات الوارد',
                                date: _selectedDate,
                                moveType: 'وارد',
                              )));
                      final state = _key.currentState;
                      if (state != null) {
                        debugPrint('isOpen:${state.isOpen}');
                        state.toggle();
                      }
                    }
                  },
                  icon: const Icon(Icons.outbond),
                  label: const Text('اضافة الوارد')),

              ///button for logout
              Consumer(
                builder: (context, ref, child) => ElevatedButton.icon(
                    onPressed: () {
                      ref.read(authControllerProvider.notifier).signOut();
                      ref.invalidate(amberRepositoryProvider);
                      ref.invalidate(authControllerProvider);
                      ref.invalidate(supaAuthRepProvider);

                      // ref.invalidate(supabaseClientProvider);
                      Navigator.pushNamedAndRemoveUntil(
                          context, '/loginpage', (route) => false);
                    },
                    icon: const Icon(Icons.logout_sharp),
                    label: const Text('تسجيل خروج')),
              ),
            ],
          )),
    );
  }
}

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
