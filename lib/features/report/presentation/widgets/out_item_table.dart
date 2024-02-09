import 'package:flutter/material.dart';
import 'package:myfarm/features/production/domain/entities/items_movement.dart';
import 'package:myfarm/utilities/constants.dart';

class OutItemTable extends StatefulWidget {
  OutItemTable(
      {super.key,
      required this.data,
      required this.reportDate,
      this.repType = reportType.daily});
  final List<ItemsMovement> data;
  final DateTime reportDate;
  final reportType repType;
  static const List<String> ColName = [
    'الكمية',
    'التفاصيل',
  ];
  static const List<String> monthColName = [
    'التاريخ',
    'الكمية',
    'التفاصيل',
  ];

  @override
  State<OutItemTable> createState() => _OutItemTableState();
}

class _OutItemTableState extends State<OutItemTable>
    with AutomaticKeepAliveClientMixin {
  //final reportType repType = reportType.daily;

  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);

    List<DataColumn> columnsNames = OutItemTable.ColName.map((e) => DataColumn(
            label: Expanded(
          child: Center(
            child: Text(e.toString(),
                style: Theme.of(context).textTheme.bodySmall),
          ),
        ))).toList();
    List<DataColumn> monthcolumnsNames = OutItemTable.monthColName
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
                  ? " التقرير اليومي للخارج بتاريخ ${widget.reportDate.toString().substring(0, 11)}"
                  : widget.repType.name == reportType.amberMonthly.name
                      ? " التقرير الشهري للخارج من عنبر(${widget.data[0].amberId})  لشهر  ${widget.reportDate.month.toString()}"
                      : " التقرير الشهري للخارج من المزرعة لشهر  ${widget.reportDate.month.toString()}",
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            columnSpacing: 10,
            horizontalMargin: 10,
            dataRowMinHeight: 10.0,
            rowsPerPage: (widget.data.length > 1)
                ? widget.data.length + 1
                : widget.data.length,
            columns: widget.repType.name == reportType.daily.name
                ? columnsNames
                : monthcolumnsNames,
            source: _DataSource(context, widget.data, widget.repType),
          ),
        )
      ],
    );
  }
}

class _outItemDaily {
  _outItemDaily(/*this.itemName,*/ this.quantity, this.details);
  //final String itemName;
  final String details;
  final double quantity;
  bool selected = false;
}

class _outItemMonthly {
  _outItemMonthly(/*this.itemName,*/ this.quantity, this.details, this.date);
  final DateTime date;
  final String details;
  final double quantity;
  bool selected = false;
}

class _DataSource extends DataTableSource {
  final BuildContext context;
  final List<dynamic> data;
  final reportType repType;

  _DataSource(this.context, this.data, this.repType) {
    ///check if report type is daily then initialize RowDaily else initialize RowMonthly
    if (repType.name == reportType.daily.name) {
      _row = <_outItemDaily>[
        for (ItemsMovement item in data)
          _outItemDaily(item.quantity, item.notes)
      ];
    } else {
      _mrow = <_outItemMonthly>[
        for (ItemsMovement item in data)
          _outItemMonthly(item.quantity, item.notes, item.movementDate)
      ];
    }
  }
  List<_outItemDaily>? _row;
  List<_outItemMonthly>? _mrow;
  final int _selectedCount = 0;
  @override

  ///if data length ==1 then no need to total row
  int get rowCount => data.length > 1 ? data.length + 1 : data.length;
  @override
  bool get isRowCountApproximate => false;
  @override
  int get selectedRowCount => _selectedCount;
  @override
  DataRow getRow(int index) {
    assert(index >= 0);

    if (index == data.length &&
        (repType.name == reportType.monthly.name ||
            repType.name == reportType.amberMonthly.name)) {
      return DataRow(cells: [
        DataCell(Center(
          child: Text(
            //data!.fold('', (p, e) => '${e.outNote!} $p').toString(),
            'اجمالي الخارج',
            style: Theme.of(context).textTheme.bodySmall,
            textAlign: TextAlign.start,
          ),
        )),
        DataCell(Center(
            child: Text(data
                .fold(0.0, (prev, element) => element.quantity + prev)
                .toString()))),
        const DataCell(
          Center(
            child: Text(''),
          ),
        ),
      ]);
    } else if (index == data.length && repType.name == reportType.daily.name) {
      return DataRow(cells: [
        DataCell(Center(
            child: Text(data
                .fold(0.0, (prev, element) => element.quantity + prev)
                .toString()))),
        const DataCell(
          Center(
            child: Text('اجمالي الخارج'),
          ),
        ),
      ]);
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
                // DataCell(Center(child: Text((row.itemName.toString())))),
                DataCell(Center(child: Text((row?.quantity.toString() ?? '')))),
                DataCell(Center(child: Text((row?.details.toString() ?? '')))),
              ]
            : [
                DataCell(Center(
                    child:
                        Text((mrow?.date.toString().substring(0, 11) ?? '')))),
                DataCell(
                    Center(child: Text((mrow?.quantity.toString() ?? '')))),
                DataCell(Center(child: Text((mrow?.details.toString() ?? '')))),
              ]);
  }
}
