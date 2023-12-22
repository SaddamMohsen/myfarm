import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myfarm/features/home/application/get_items_list_data.dart';
import 'package:myfarm/features/production/application/add_production_provider.dart';
import 'package:myfarm/features/production/domain/repositories/ambers_repository.dart';
import 'package:myfarm/features/report/application/amber_report_provider.dart';
import 'package:myfarm/features/report/presentation/widgets/out_item_table.dart';

class OutReportWidget extends ConsumerStatefulWidget {
  const OutReportWidget({super.key, required this.repDate});
  final DateTime repDate;
  @override
  ConsumerState<OutReportWidget> createState() => _OutReportWidgetState();
}

class _OutReportWidgetState extends ConsumerState<OutReportWidget> {
  //selected amber to get the report for
  late dynamic dropDownvalue;
  //is report for all farm
  dynamic monthdropDownvalue = 0;
  //the item code
  String itemCode = '001-001';
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

  @override
  Widget build(BuildContext context) {
    final AsyncValue<List<Item>> items = ref.watch(getItemsListProvider);
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.11,
          padding: const EdgeInsets.only(bottom: 6),
          //color: Theme.of(context).colorScheme.background,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                  color: Theme.of(context).colorScheme.primary, width: 1)),
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
                    top: 15,
                    left: 6,
                    right: 6,
                  ),
                  decoration: BoxDecoration(
                    //  color: Theme.of(context).primaryColor.withAlpha(50),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  //
                  child: Consumer(builder: (_, WidgetRef ref, __) {
                    final ambers = ref.watch(ambersProviderNotifier);

                    return ambers.when(
                      loading: () =>
                          const Center(child: CircularProgressIndicator()),
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
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          Container(
                            width: 90,
                            height: 40,
                            margin: EdgeInsets.only(right: 5),
                            //padding: EdgeInsets.only(bottom: 15),
                            decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.onPrimary,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                    color: Colors.black,
                                    width: 1,
                                    style: BorderStyle.solid)),
                            child: Directionality(
                              textDirection: TextDirection.rtl,
                              child: DropdownButton(
                                  isExpanded: true,
                                  value: dropDownvalue,
                                  style: Theme.of(context).textTheme.bodySmall,
                                  borderRadius: BorderRadius.circular(12),
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
                  padding: const EdgeInsets.only(top: 15, left: 10, right: 0),
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
                            color: Theme.of(context).colorScheme.onPrimary,
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
                              style: Theme.of(context).textTheme.bodySmall,
                              borderRadius: BorderRadius.circular(12),
                              icon: const Icon(Icons.arrow_drop_down),
                              iconSize: 24,
                              items: const [
                                DropdownMenuItem<int>(
                                    value: 0, child: Text('تقرير يومي')),
                                DropdownMenuItem<int>(
                                    value: 1, child: Text(' تقرير شهري ')),
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
              Expanded(
                flex: 0,
                child: Container(
                  width: 115,
                  height: 100,
                  padding: const EdgeInsets.only(top: 15, left: 10, right: 0),
                  decoration: BoxDecoration(
                    //color: Theme.of(context).primaryColor.withAlpha(50),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  //
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        'نوع الخارج ',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      items.when(
                        data: (data) => Container(
                          width: 100,
                          height: 40,
                          padding: const EdgeInsets.only(right: 5),
                          decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.onPrimary,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                  color: Colors.black,
                                  width: 1,
                                  style: BorderStyle.solid)),
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: DropdownButton(
                                isExpanded: true,
                                value: itemCode,
                                style: Theme.of(context).textTheme.bodySmall,
                                borderRadius: BorderRadius.circular(12),
                                icon: const Icon(Icons.arrow_drop_down),
                                iconSize: 24,
                                items:
                                    data.map<DropdownMenuItem<String>>((item) {
                                  return DropdownMenuItem<String>(
                                    value: item.itemCode,
                                    child: Text(item.itemName),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  // print(value);
                                  setState(() {
                                    itemCode = value ?? '';
                                  });
                                }),
                          ),
                        ),
                        error: (error, stackTrace) => Text(error.toString()),
                        loading: () => const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
            flex: 4,
            child: Consumer(
              builder: (context, ref, child) {
                final report = ref.watch(outItemsDailyReportProvider(
                    itemCode: itemCode,
                    amberId: dropDownvalue,
                    repDate: widget.repDate));

                return report.when(
                  data: (data) {
                    return data.isNotEmpty
                        ? OutItemTable(
                            data: data,
                            reportDate: widget.repDate,
                            //repType: reportType.monthly,
                          )
                        : Center(
                            child: Text(
                              'لا توجد بيانات متعلقه بهذا الصنف',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          );
                  },
                  error: (err, stackTrace) => Text(err.toString()),
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                );
              },
            )),
      ],
    );
  }
}
