import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myfarm/features/production/application/add_production_provider.dart';
import 'package:myfarm/features/production/domain/repositories/ambers_repository.dart';
import 'package:myfarm/features/report/application/amber_report_provider.dart';
import 'package:myfarm/features/report/application/farm_report_provider.dart';
import 'package:myfarm/features/report/presentation/widgets/out_report_widget.dart';
import 'package:myfarm/features/report/presentation/widgets/repoort_table.dart';
import 'package:myfarm/utilities/constants.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key, required this.repDate});
  final DateTime repDate;

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  //selected amber to get the report for
  late dynamic dropDownvalue;
  //is report for all farm
  bool reportForFarm = true;
  dynamic monthdropDownvalue = 0;
  List<DropdownMenuItem<int>> allItem = [
    const DropdownMenuItem<int>(value: 0, child: Text('الكل'))
  ];

  @override
  void initState() {
    super.initState();
    dropDownvalue = 0;
    //monthdropDownvalue = null;
  }

  List<DropdownMenuItem<int>> getAmberList(List<Amber> data) {
    List<DropdownMenuItem<int>> newItem = data.map<DropdownMenuItem<int>>((e) {
      return DropdownMenuItem<int>(value: e.id, child: Text('${e.id} عنبر'));
    }).toList();
    // allItem.addAll(newItem);
    List<DropdownMenuItem<int>> allItems = allItem + newItem;
    return allItems;
  }

//TabController controller=TabController(length: 2, vsync: vsync)
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(

                // unselectedLabelColor: Theme.of(context).cardColor,
                // indicatorColor: Theme.of(context).colorScheme.secondary,
                indicator: BoxDecoration(
                  //color: Theme.of(context).focusColor,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(6),
                      topRight: Radius.circular(6)),
                  //color: Theme.of(context).colorScheme.secondaryContainer,
                  border: Border.all(
                    color: Theme.of(context).colorScheme.primary,
                    width: 1,
                    style: BorderStyle.solid,
                  ),
                ),
                // splashBorderRadius: BorderRadius.circular(40),
                tabs: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(6),
                          topRight: Radius.circular(6)),
                    ),
                    child: Text(
                      'تقرير الانتاج',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(6),
                            topRight: Radius.circular(6)),
                      ),
                      child: Text(
                        'تقرير الخارج',
                        style: Theme.of(context).textTheme.bodyMedium,
                      )),
                  Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(6),
                            topRight: Radius.circular(6)),
                      ),
                      child: Text(
                        'تقرير المخزون',
                        style: Theme.of(context).textTheme.bodyMedium,
                      )),
                ]),
          ),
          body: TabBarView(children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 0,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.1,
                    margin: const EdgeInsets.only(right: 6, left: 6),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            color: Theme.of(context).colorScheme.primary,
                            width: 1)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisSize: MainAxisSize.max,
                      textDirection: TextDirection.rtl,
                      children: [
                        Expanded(
                          flex: 0,
                          child: Container(
                            width: 120,
                            height: 100,
                            margin: const EdgeInsets.only(right: 4),
                            padding: const EdgeInsets.only(
                                top: 15, left: 6, right: 6, bottom: 6),
                            decoration: BoxDecoration(
                              //  color: Theme.of(context).primaryColor.withAlpha(50),
                              borderRadius: BorderRadius.circular(12),
                              // border: Border.all(
                              //     color: Colors.black,
                              //     width: 0,
                              //     style: BorderStyle.solid),
                            ),
                            //
                            child: Consumer(builder: (_, WidgetRef ref, __) {
                              final ambers = ref.watch(ambersProviderNotifier);

                              return ambers.when(
                                loading: () => const Center(
                                    child: CircularProgressIndicator()),
                                error: (err, stack) => Text('خطأ: $err'),
                                data: (data) => Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(
                                      'حدد رقم العنبر',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                              fontWeight: FontWeight.bold),
                                    ),
                                    Container(
                                      width: 90,
                                      height: 40,
                                      margin: const EdgeInsets.only(right: 5),
                                      // padding: EdgeInsets.only(bottom: 15),
                                      decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onPrimary,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          border: Border.all(
                                              color: Colors.black,
                                              width: 1,
                                              style: BorderStyle.solid)),
                                      child: Directionality(
                                        textDirection: TextDirection.rtl,
                                        child: DropdownButton(
                                            isExpanded: true,
                                            value: dropDownvalue,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall,
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            icon: Icon(Icons.arrow_drop_down),
                                            iconSize: 24,
                                            items: getAmberList(data),
                                            onChanged: (value) {
                                              setState(() {
                                                dropDownvalue = value ?? 0;
                                                if (dropDownvalue >= 1) {}
                                                // reportForFarm = false;
                                              });
                                            }),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                          ),
                        ),
                        Expanded(
                          flex: 0,
                          child: Container(
                            width: 115,
                            height: 100,
                            padding: const EdgeInsets.only(
                                top: 15, left: 10, right: 0),
                            decoration: BoxDecoration(
                              //color: Theme.of(context).primaryColor.withAlpha(50),
                              borderRadius: BorderRadius.circular(12),
                              // border:
                              //  Border.all(
                              //     color: Colors.black,
                              //     width: 0.5,
                              //     style: BorderStyle.solid),
                            ),
                            //
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  'نوع التقرير ',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(fontWeight: FontWeight.bold),
                                ),
                                Container(
                                  width: 100,
                                  height: 40,
                                  padding: const EdgeInsets.only(right: 5),
                                  decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary,
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                          color: Colors.black,
                                          width: 1,
                                          style: BorderStyle.solid)),
                                  child: Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: DropdownButton(
                                        isExpanded: true,
                                        value: monthdropDownvalue,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall,
                                        borderRadius: BorderRadius.circular(12),
                                        icon: const Icon(Icons.arrow_drop_down),
                                        iconSize: 24,
                                        items: const [
                                          DropdownMenuItem<int>(
                                              value: 0,
                                              child: Text('تقرير يومي')),
                                          DropdownMenuItem<int>(
                                              value: 1,
                                              child: Text(' تقرير شهري ')),
                                          // DropdownMenuItem(
                                          //     value: 2,
                                          //     child: Text('شهري للمزرعة')),
                                        ],
                                        onChanged: (value) {
                                          // print(value);
                                          setState(() {
                                            monthdropDownvalue = value ?? 0;
                                            if (value == 2) {
                                              //reportForFarm = true;
                                              dropDownvalue = 0;
                                            }
                                          });
                                        }),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                ///body of the page
                Expanded(
                    flex: 5,

                    ///adding  else if  monthDropDownvalue ==1 and reportTofarm==false then show Monthly  report for amber

                    child: (monthdropDownvalue == 1 && dropDownvalue != 0)
                        ? Consumer(
                            builder: (context, ref, child) {
                              final report = ref.watch(AmberMonthReportProvider(
                                  amberId: dropDownvalue,
                                  repDate: widget.repDate));
                              return report.when(
                                data: (data) {
                                  // print(data.length);

                                  return Container(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 6, horizontal: 6),
                                    child: MyReportTable(
                                      data: data,
                                      reportDate: widget.repDate,
                                      repType: reportType.amberMonthly,
                                    ),
                                  );
                                },
                                error: (err, stackTrace) =>
                                    Text(err.toString()),
                                loading: () => const Center(
                                    child: CircularProgressIndicator()),
                              );
                            },
                          )

                        //if dropdwonvalue =>1 and reportfarm==false then show the daily report of amber
                        : (dropDownvalue > 0 && monthdropDownvalue == 0)
                            ? Consumer(
                                builder: (context, ref, child) {
                                  final report = ref.watch(AmberReportProvider(
                                      amberId: dropDownvalue,
                                      repDate: widget.repDate));
                                  return report.when(
                                    data: (data) {
                                      if (data.amberId == null)
                                        return Text('لا يوجد');
                                      return MyReportTable(
                                        data: [data],
                                        reportDate: widget.repDate,
                                        repType: reportType.daily,
                                      );
                                    },
                                    error: (err, stackTrace) =>
                                        Text(err.toString()),
                                    loading: () => const Center(
                                        child: CircularProgressIndicator()),
                                  );
                                },
                              )

                            ///if monthDropDownvalue ==2 and dropdownValue=0 and reportForFarm is true then show daily report for farm
                            : (dropDownvalue == 0 && monthdropDownvalue == 0)
                                ? Consumer(
                                    builder: (context, ref, child) {
                                      final report = ref.watch(
                                          FarmReportProvider(
                                              repDate: widget.repDate));

                                      return report.when(
                                        data: (data) {
                                          return MyReportTable(
                                            data: data,
                                            reportDate: widget.repDate,
                                            repType: reportType.daily,
                                          );
                                        },
                                        error: (err, stackTrace) =>
                                            Text(err.toString()),
                                        loading: () => const Center(
                                            child: CircularProgressIndicator()),
                                      );
                                    },
                                  )

                                /// else show monthly report to farm
                                : Consumer(
                                    builder: (context, ref, child) {
                                      final report = ref.watch(
                                          monthFarmReportProvider(
                                              repDate: widget.repDate));

                                      return report.when(
                                        data: (data) {
                                          return MyReportTable(
                                            data: data,
                                            reportDate: widget.repDate,
                                            repType: reportType.monthly,
                                          );
                                        },
                                        error: (err, stackTrace) =>
                                            Text(err.toString()),
                                        loading: () => const Center(
                                            child: CircularProgressIndicator()),
                                      );
                                    },
                                  )),
              ],
            ),

            OutReportWidget(
              repDate: widget.repDate,
            ),
            // Text('تقرير الوارد قيد الانشاء'),
            Text('تقرير المخزون قيد الانشاء'),
          ]),
        ),
      ),
    );
  }
}
// Widget tab1(BuildContext context){
//   return
//   */