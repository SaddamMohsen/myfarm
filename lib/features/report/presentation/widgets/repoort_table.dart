import 'package:flutter/material.dart';
import 'package:myfarm/features/report/domain/entities/amber_month_report.dart';

import 'package:myfarm/features/report/domain/entities/dailyreport.dart';
import 'package:myfarm/features/report/domain/entities/monthlyreport.dart';
import 'package:myfarm/utilities/constants.dart';

///
class MyReportTable extends StatefulWidget {
  const MyReportTable(
      {super.key,
      required this.data,
      required this.reportDate,
      required this.repType});
  final List<dynamic> data;
  final DateTime reportDate;
  final reportType repType;
  static const List<String> monthColName = [
    'التاريخ',
    'الوفيات',
    'العلف الوارد',
    'العلف المستهلك',
    'العلف المتبقي',
    'الانتاج طبق',
    'الانتاج كرتون',
    'الخارج طبق',
    'الخارج كرتون',
    'بيانات الخارج',
    'المتبقي طبق',
    'المتبقي كرتون'
  ];

  @override
  State<MyReportTable> createState() => _MyReportTableState();
}

class _MyReportTableState extends State<MyReportTable>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    var columns2 = [
      DataColumn(
          label: Expanded(
        child: Center(
          child: Text(
            "ملاحظات",
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
      )),
      DataColumn(
          label: Expanded(
        child: Center(
          child: Text("المتبقي كرتون",
              style: Theme.of(context).textTheme.bodySmall),
        ),
      )),
      DataColumn(
          label: Expanded(
        child: Center(
          child:
              Text("المتبقي طبق", style: Theme.of(context).textTheme.bodySmall),
        ),
      )),
      DataColumn(
          label: Expanded(
        child: Center(
          child: Text("الخارج كرتون",
              style: Theme.of(context).textTheme.bodySmall),
        ),
      )),
      DataColumn(
          label: Expanded(
        child: Center(
          child:
              Text('الخارج طبق', style: Theme.of(context).textTheme.bodySmall),
        ),
      )),
      DataColumn(
          label: Expanded(
        child: Center(
          child: Text('الانتاج كرتون',
              style: Theme.of(context).textTheme.bodySmall),
        ),
      )),

      DataColumn(
          label: Expanded(
        child: Center(
          child:
              Text('الانتاج طبق', style: Theme.of(context).textTheme.bodySmall),
        ),
      )),
      DataColumn(
          label: Expanded(
        child: Center(
          child:
              Text("المتبقي علف", style: Theme.of(context).textTheme.bodySmall),
        ),
      )),
      DataColumn(
          label: Expanded(
        child: Center(
          child: Text("المستهلك", style: Theme.of(context).textTheme.bodySmall),
        ),
      )),
      DataColumn(
          label: Expanded(
        child: Center(
          child: Text("العلف الواصل",
              style: Theme.of(context).textTheme.bodySmall),
        ),
      )),
      DataColumn(
          label: Expanded(
        child: Center(
          child: Text("الوفيات", style: Theme.of(context).textTheme.bodySmall),
        ),
      )),
      DataColumn(
          label: Expanded(
        child: Center(
          child: Text("عنبر", style: Theme.of(context).textTheme.bodySmall),
        ),
      )),

      // DataColumn(label: Text('تعديل')),
    ].reversed.toList();
    List<DataColumn> columnsMonth = MyReportTable.monthColName
        .map((e) => DataColumn(
                label: Expanded(
              child: Center(
                child: Text(e.toString(),
                    style: Theme.of(context).textTheme.bodySmall),
              ),
            )))
        .toList();
    return ListView(
      padding: const EdgeInsets.all(0),
      children: [
        Directionality(
          textDirection: TextDirection.rtl,
          child: PaginatedDataTable(
            controller: ScrollController(
                keepScrollOffset: true, initialScrollOffset: 10.0),
            header: Text(
              widget.repType.name == reportType.daily.name
                  ? " التقرير اليومي بتاريخ ${widget.reportDate.toString().substring(0, 11)}"
                  : " التقرير الشهري لشهر  ${widget.reportDate.month.toString()}",
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            columnSpacing: 10,
            horizontalMargin: 10,
            dataRowMinHeight: 10.0,
            rowsPerPage: widget.data.length > 1
                ? widget.data.length + 1
                : widget.data.length,
            columns: widget.repType.name == reportType.daily.name
                ? columns2
                : columnsMonth,
            source: _DataSource(context, widget.data, widget.repType),
          ),
        )
      ],
    );
  }
}

class _RowDaily {
  _RowDaily(
      // this.row_id,
      this.amberId,
      this.death,
      this.incomFeed,
      this.intakFeed,
      this.remainFeed,
      this.prodTray,
      this.prodCarton,
      this.outTray,
      this.outCarton,
      this.remainTray,
      this.remainCarton,
      this.note);
  //final DailyDataModel data;
  final int amberId;
  //int? row_id;
  int? death;
  int? incomFeed;
  final double intakFeed;
  final double remainFeed;
  final int prodCarton;
  final int prodTray;
  int? outCarton;
  int? outTray;
  int remainTray;
  int remainCarton;
  final String note;

  bool selected = false;
}

class _RowMonthly {
  _RowMonthly(
      // this.row_id,
      this.prodDate,
      this.death,
      this.incomFeed,
      this.intakFeed,
      this.remainFeed,
      this.prodTray,
      this.prodCarton,
      this.outTray,
      this.outCarton,
      this.remainTray,
      this.remainCarton,
      this.note);
  //final DailyDataModel data;
  final DateTime prodDate;
  //int? row_id;
  int? death;
  int? incomFeed;
  final double intakFeed;
  final double remainFeed;
  final int prodCarton;
  final int prodTray;
  int? outCarton;
  int? outTray;
  int remainTray;
  int remainCarton;
  String note;

  bool selected = false;
}

class _DataSource extends DataTableSource {
  _DataSource(this.context, this.data, this.repType) {
    ///check if report type is daily then initialize RowDaily else initialize RowMonthly
    if (repType.name == reportType.daily.name) {
      _row = <_RowDaily>[
        for (DailyReport item in data)
          _RowDaily(
            item.amberId,
            item.death,
            item.incomFeed,
            item.intakFeed,
            item.reminFeed,
            item.prodTray,
            item.prodCarton,
            item.outTray,
            item.outCarton,
            item.remainEgg[0],
            item.remainEgg[1],
            item.outNote,
          )
      ];
    } else if (repType.name == reportType.amberMonthly.name) {
      print(data);
      _mrow = <_RowMonthly>[
        for (AmberMonthlyReport item in data)
          _RowMonthly(
              item.prodDate,
              item.death,
              item.incomFeed,
              item.intakFeed,
              item.reminFeed,
              item.prodTray,
              item.prodCarton,
              item.outTray,
              item.outCarton,
              item.remainEgg[0],
              item.remainEgg[1],
              item.outNote ?? '')
      ];
    } else {
      _mrow = <_RowMonthly>[
        for (MonthlyReport item in data)
          _RowMonthly(
              item.prodDate,
              item.death,
              item.incomFeed,
              item.intakFeed,
              item.reminFeed,
              item.prodEgg[0],
              item.prodEgg[1],
              item.outEgg[0],
              item.outEgg[1],
              item.remainEgg[0],
              item.remainEgg[1],
              '')
      ];
    }
  }

  final BuildContext context;
  final List<dynamic> data;
  final reportType repType;

  ///used to initialize rows if the type daily report
  List<_RowDaily>? _row;

  ///used to initialize rows if the type monthly report
  List<_RowMonthly>? _mrow;

  final int _selectedCount = 0;
  @override

  ///if data length ==1 then no need to total row
  int get rowCount => repType.name == reportType.daily.name
      ? data.length == 1
          ? _row!.length
          : _row!.length + 1
      : data.length == 1
          ? _mrow!.length
          : _mrow!.length + 1;
  @override
  bool get isRowCountApproximate => false;
  @override
  int get selectedRowCount => _selectedCount;
  @override
  DataRow getRow(int index) {
    assert(index >= 0);

    ///if index ==length and report type is daily then add new row that calculate total of daliyRow
    ///else  if index ==length and report type is monthly then add new row that calculate monthly total
    ///else if index ==length and report type is amber monthly then add new row that calculate monthly total of amber
    if (index == data.length && repType.name == reportType.daily.name) {
      return DataRow(
          cells: [
        DataCell(Center(
          child: Text(
            //data!.fold('', (p, e) => '${e.outNote!} $p').toString(),
            '',
            style: Theme.of(context).textTheme.bodySmall,
            textAlign: TextAlign.start,
          ),
        )),
        DataCell(Center(
            child: Text(data
                .fold(0, (prev, element) => element.remainEgg[1] + prev)
                .toString()))),
        DataCell(Center(
            child: Text(data
                .fold(0, (prev, element) => element.remainEgg[0] + prev)
                .toString()))),
        DataCell(Center(
            child: Text(data
                .fold(0, (prev, element) => element.outCarton + prev)
                .toString()))),
        DataCell(Center(
            child: Text(data
                .fold(0, (prev, element) => element.outTray + prev)
                .toString()))),
        DataCell(Center(
            child: Text(data
                .fold(0, (prev, element) => element.prodTray + prev)
                .toString()))),
        DataCell(Center(
            child: Text(data
                .fold(0, (prev, element) => element.prodCarton + prev)
                .toString()))),
        DataCell(Center(
            child: Text(data
                .fold(0.0, (prev, element) => element.reminFeed + prev)
                .toString()))),
        DataCell(Center(
            child: Text(data
                .fold(0.0, (prev, element) => element.intakFeed + prev)
                .toString()))),
        DataCell(Center(
            child: Text(data
                .fold(0, (prev, element) => element.incomFeed + prev)
                .toString()))),
        DataCell(Center(
            child: Text(data
                .fold(0, (prev, element) => element.death + prev)
                .toString()))),
        const DataCell(
          Center(
            child: Text(
              'الاجماليات',
              textAlign: TextAlign.start,
            ),
          ),
        ),
      ].reversed.toList());
    }

    ///end of if
    ///return the sum of monthly report by farm
    else if (index == data.length && repType.name == reportType.monthly.name) {
      return DataRow(
          cells: [
        DataCell(Center(
            child: Text((data.fold(
                        0, (prev, element) => element.remainEgg[1] + 0) +
                    ((data.fold(
                            0, (prev, element) => element.remainEgg[0] + 0) ~/
                        12)))
                .toString()))),
        DataCell(Center(
            child: Text(data
                .fold(0, (prev, element) => element.remainEgg[0] + 0)
                .remainder(12)
                .toString()))),
        const DataCell(
          Center(
            child: Text(
              ' ',
              textAlign: TextAlign.start,
            ),
          ),
        ),
        DataCell(Center(
            child: Text((data.fold(
                        0, (prev, element) => element.outEgg[1] + prev) +
                    ((data.fold(0,
                                (prev, element) => element.outEgg[0] + prev) ~/
                            12)
                        .toInt()))
                .toString()))),
        DataCell(Center(
            child: Text(data
                .fold(0, (prev, element) => element.outEgg[0] + prev)
                .remainder(12)
                .toString()))),
        DataCell(Center(
            child: Text((data.fold(
                        0, (prev, element) => element.prodEgg[1] + prev) +
                    ((data.fold(0,
                                (prev, element) => element.prodEgg[0] + prev) ~/
                            12)
                        .toInt()))
                .toString()))),
        DataCell(Center(
            child: Text(data
                .fold(0, (prev, element) => element.prodEgg[0] + prev)
                .remainder(12)
                .toString()))),
        DataCell(Center(
            child: Text(data
                .fold(0.0, (prev, element) => element.reminFeed + 0)
                .toString()))),
        DataCell(Center(
            child: Text(data
                .fold(0.0, (prev, element) => element.intakFeed + prev)
                .toString()))),
        DataCell(Center(
            child: Text(data
                .fold(0, (prev, element) => element.incomFeed + prev)
                .toString()))),
        DataCell(Center(
            child: Text(data
                .fold(0, (prev, element) => element.death + prev)
                .toString()))),
        const DataCell(
          Center(
            child: Text(
              'الاجماليات',
              textAlign: TextAlign.start,
            ),
          ),
        ),
      ].reversed.toList());
    }

    ///return the sum of report monthly by amber
    else if (index == data.length &&
        repType.name == reportType.amberMonthly.name) {
      return DataRow(
          cells: [
        DataCell(Center(
            child: Text((data.fold(
                        0, (prev, element) => element.remainEgg[1] + 0) +
                    ((data.fold(
                            0, (prev, element) => element.remainEgg[0] + 0) ~/
                        12)))
                .toString()))),
        DataCell(Center(
            child: Text(data
                .fold(0, (prev, element) => element.remainEgg[0] + 0)
                .remainder(12)
                .toString()))),
        const DataCell(
          Center(
            child: Text(
              ' ',
              textAlign: TextAlign.start,
            ),
          ),
        ),
        DataCell(Center(
            child: Text((data.fold(
                        0, (prev, element) => element.outCarton + prev) +
                    ((data.fold(0, (prev, element) => element.outTray + prev) ~/
                            12)
                        .toInt()))
                .toString()))),
        DataCell(Center(
            child: Text(data
                .fold(0, (prev, element) => element.outTray + prev)
                .remainder(12)
                .toString()))),
        DataCell(Center(
            child: Text((data.fold(
                        0, (prev, element) => element.prodCarton + prev) +
                    ((data.fold(0,
                                (prev, element) => element.prodTray + prev) ~/
                            12)
                        .toInt()))
                .toString()))),
        DataCell(Center(
            child: Text(data
                .fold(0, (prev, element) => element.prodTray + prev)
                .remainder(12)
                .toString()))),
        DataCell(Center(
            child: Text(data
                .fold(0.0, (prev, element) => element.reminFeed + prev)
                .toString()))),
        DataCell(Center(
            child: Text(data
                .fold(0.0, (prev, element) => element.intakFeed + prev)
                .toString()))),
        DataCell(Center(
            child: Text(data
                .fold(0, (prev, element) => element.incomFeed + prev)
                .toString()))),
        DataCell(Center(
            child: Text(data
                .fold(0, (prev, element) => element.death + prev)
                .toString()))),
        const DataCell(
          Center(
            child: Text(
              'الاجماليات',
              textAlign: TextAlign.start,
            ),
          ),
        ),
      ].reversed.toList());
    }

    final row = _row?[index];
    final mrow = _mrow?[index];
    return DataRow.byIndex(
      index: index,
      selected: repType.name == reportType.daily.name
          ? row!.selected
          : mrow!.selected,
      color: MaterialStateColor.resolveWith((Set<MaterialState> states) {
        if (states.contains(MaterialState.selected)) {
          return Theme.of(context).colorScheme.primary;
        }

        return Theme.of(context).colorScheme.onPrimary;
      }),
      cells: repType.name == reportType.daily.name
          ? [
              DataCell(
                Center(
                  child: Text(
                    row?.amberId.toString() ?? '',
                    textAlign: TextAlign.start,
                  ),
                ),
              ),
              DataCell(Center(child: Text(row?.death.toString() ?? ''))),
              DataCell(Center(child: Text(row?.incomFeed.toString() ?? ''))),
              DataCell(Center(child: Text(row?.intakFeed.toString() ?? ''))),
              DataCell(Center(child: Text(row?.remainFeed.toString() ?? ''))),
              DataCell(Center(child: Text(row?.prodTray.toString() ?? ''))),
              DataCell(Center(child: Text(row?.prodCarton.toString() ?? ''))),
              DataCell(Center(child: Text(row?.outTray.toString() ?? ''))),
              DataCell(Center(child: Text(row?.outCarton.toString() ?? ''))),
              DataCell(Center(child: Text(row?.remainTray.toString() ?? ''))),
              DataCell(Center(child: Text(row?.remainCarton.toString() ?? ''))),
              DataCell(Center(
                child: Text(
                  row?.note.toString() ?? '',
                  style: Theme.of(context).textTheme.bodySmall,
                  textAlign: TextAlign.start,
                ),
              )),
            ]
          : [
              DataCell(Center(
                child: Text(
                  mrow?.prodDate.toString().substring(0, 11) ?? '',
                  style: Theme.of(context).textTheme.bodySmall,
                  textAlign: TextAlign.start,
                ),
              )),
              DataCell(Center(child: Text(mrow?.death.toString() ?? ''))),
              DataCell(Center(child: Text(mrow?.incomFeed.toString() ?? ''))),
              DataCell(Center(child: Text(mrow?.intakFeed.toString() ?? ''))),
              DataCell(Center(child: Text(mrow?.remainFeed.toString() ?? ''))),
              DataCell(Center(child: Text(mrow?.prodTray.toString() ?? ''))),
              DataCell(Center(child: Text(mrow?.prodCarton.toString() ?? ''))),
              DataCell(Center(child: Text(mrow?.outTray.toString() ?? ''))),
              DataCell(Center(child: Text(mrow?.outCarton.toString() ?? ''))),
              DataCell(Center(
                child: Text(
                  mrow?.note.toString() ?? '',
                  style: Theme.of(context).textTheme.bodySmall,
                  textAlign: TextAlign.start,
                ),
              )),
              DataCell(Center(child: Text(mrow?.remainTray.toString() ?? ''))),
              DataCell(
                  Center(child: Text(mrow?.remainCarton.toString() ?? ''))),
            ],
      // onSelectChanged: (value) {
      //   if (row.selected != value) {
      //     _selectedCount += value! ? 1 : -1;
      //     assert(_selectedCount >= 0);
      //     row.selected = value;
      //     notifyListeners();
      //   }
      // },
    );
  }
}
