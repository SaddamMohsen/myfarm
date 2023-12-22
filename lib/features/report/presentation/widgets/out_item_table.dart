import 'package:flutter/material.dart';
import 'package:myfarm/features/production/domain/entities/items_movement.dart';
import 'package:myfarm/utilities/constants.dart';

class OutItemTable extends StatelessWidget {
  const OutItemTable({super.key, required this.data, required this.reportDate});
  final List<ItemsMovement> data;
  final DateTime reportDate;
  final reportType repType = reportType.daily;

  static const List<String> ColName = [
    //'الصنف',
    'الكمية',
    'التفاصيل',
  ];

  @override
  Widget build(BuildContext context) {
    List<DataColumn> columnsNames = ColName.map((e) => DataColumn(
            label: Expanded(
          child: Center(
            child: Text(e.toString(),
                style: Theme.of(context).textTheme.bodySmall),
          ),
        ))).toList();
    return ListView(
      padding: const EdgeInsets.all(0),
      children: [
        Directionality(
          textDirection: TextDirection.rtl,
          child: PaginatedDataTable(
            controller: ScrollController(
                keepScrollOffset: true, initialScrollOffset: 10.0),
            header: Text(
              repType.name == reportType.daily.name
                  ? " التقرير اليومي للخارج بتاريخ ${reportDate.toString().substring(0, 11)}"
                  : " التقرير الشهري لشهر  ${reportDate.month.toString()}",
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            columnSpacing: 10,
            horizontalMargin: 10,
            dataRowMinHeight: 10.0,
            rowsPerPage: data.length > 1 ? data.length + 1 : data.length,
            columns: columnsNames,
            source: _DataSource(context, data, repType),
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
    }
  }
  List<_outItemDaily>? _row;

  final int _selectedCount = 0;
  @override

  ///if data length ==1 then no need to total row
  int get rowCount => data.length;
  @override
  bool get isRowCountApproximate => false;
  @override
  int get selectedRowCount => _selectedCount;
  @override
  DataRow getRow(int index) {
    assert(index >= 0);

    final row = _row?[index];
    return DataRow.byIndex(
        index: index,
        selected: row!.selected,
        color: MaterialStateColor.resolveWith((Set<MaterialState> states) {
          if (states.contains(MaterialState.selected)) {
            return Theme.of(context).colorScheme.primary;
          }

          return Theme.of(context).colorScheme.onPrimary;
        }),
        cells: [
          // DataCell(Center(child: Text((row.itemName.toString())))),
          DataCell(Center(child: Text((row.quantity.toString())))),
          DataCell(Center(child: Text((row.details.toString())))),
        ]);
  }
}
