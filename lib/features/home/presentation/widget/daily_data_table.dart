import 'package:flutter/material.dart';
import 'package:myfarm/features/home/presentation/widget/edit_dialog.dart';
import 'package:myfarm/features/production/domain/entities/dailydata.dart';

import '../../../report/presentation/report_screen.dart';

class MyDataTable extends StatelessWidget {
  const MyDataTable({super.key, required this.data});
  final List<DailyDataModel> data;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.5,
        child: Card(
          elevation: 5,
          child: ListView(
            padding: const EdgeInsets.all(2),
            children: [
              PaginatedDataTable(
                header: Text(
                  " التقرير اليومي بتاريخ ${data[0].prodDate.toString().substring(0, 11)}",
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                columnSpacing: 16,
                horizontalMargin: 15,
                dataRowMinHeight: 15.0,
                rowsPerPage: data.length + 1,
                columns: [
                  DataColumn(
                      label: Expanded(
                    child: Center(
                      child: Text("تعديل",
                          style: Theme.of(context).textTheme.bodySmall),
                    ),
                  )),
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
                      child: Text("الخارج كرتون",
                          style: Theme.of(context).textTheme.bodySmall),
                    ),
                  )),
                  DataColumn(
                      label: Expanded(
                    child: Center(
                      child: Text('الخارج طبق',
                          style: Theme.of(context).textTheme.bodySmall),
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
                      child: Text('الانتاج طبق',
                          style: Theme.of(context).textTheme.bodySmall),
                    ),
                  )),
                  DataColumn(
                      label: Expanded(
                    child: Center(
                      child: Text("المستهلك",
                          style: Theme.of(context).textTheme.bodySmall),
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
                      child: Text("الوفيات",
                          style: Theme.of(context).textTheme.bodySmall),
                    ),
                  )),
                  DataColumn(
                      label: Expanded(
                    child: Center(
                      child: Text("عنبر",
                          style: Theme.of(context).textTheme.bodySmall),
                    ),
                  )),

                  // DataColumn(label: Text('تعديل')),
                ],
                source: _DataSource(context, data),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _Row {
  _Row(this.row_id, this.amberId, this.death, this.incomFeed, this.intakFeed,
      this.prodCarton, this.prodTray, this.outCarton, this.outTray, this.note);
  //final DailyDataModel data;
  final int amberId;
  int? row_id;
  int? death;
  int? incomFeed;
  final double intakFeed;
  final int prodCarton;
  final int prodTray;
  int? outCarton;
  int? outTray;
  final String note;

  bool selected = false;
}

class _DataSource extends DataTableSource {
  _DataSource(this.context, this.data) {
    _row = <_Row>[
      for (DailyDataModel item in data)
        _Row(
          item.trId,
          item.amberId,
          item.death,
          item.incomFeed,
          item.intakFeed,
          item.prodCarton ?? 0,
          item.prodTray ?? 0,
          item.outEggsCarton ?? 0,
          item.outEggsTray ?? 0,
          item.outEggsNote ?? '',
        )
    ];
  }

  final BuildContext context;
  final List<DailyDataModel> data;
  List<_Row>? _row;
  final int _selectedCount = 0;
  @override
  int get rowCount => data.length == 1 ? _row!.length : _row!.length + 1;
  @override
  bool get isRowCountApproximate => false;
  @override
  int get selectedRowCount => _selectedCount;

  @override
  DataRow getRow(int index) {
    assert(index >= 0);
    // if index greater than length so return the total row else return rows
    if (index >= data.length) {
      return DataRow(cells: [
        DataCell(
          Center(
            child: InkWell(
                child: const Icon(Icons.wysiwyg),
                onTap: () {
                  //on press this show report page
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ReportScreen(repDate: data[0].prodDate)),
                  ).onError(
                      (error, stackTrace) => debugPrint(error.toString()));
                }),
          ),
        ),
        DataCell(Center(
          child: Text(
            data.fold('', (p, e) => '${e.outEggsNote!} $p').toString(),
            style: Theme.of(context).textTheme.bodySmall,
            textAlign: TextAlign.start,
            overflow: TextOverflow.fade,
          ),
        )),
        DataCell(Center(
            child:
                Text(data.fold(0, (p, e) => e.outEggsCarton! + p).toString()))),
        DataCell(Center(
            child:
                Text(data.fold(0, (p, e) => e.outEggsTray! + p).toString()))),
        DataCell(Center(
            child: Text(data.fold(0, (p, e) => e.prodCarton! + p).toString()))),
        DataCell(Center(
            child: Text(data.fold(0, (p, e) => e.prodTray! + p).toString()))),
        DataCell(Center(
            child: Text(data.fold(0.0, (p, e) => e.intakFeed + p).toString()))),
        DataCell(Center(
            child: Text(data.fold(0, (p, e) => e.incomFeed! + p).toString()))),
        DataCell(Center(
            child: Text(data.fold(0, (p, e) => e.death! + p).toString()))),
        const DataCell(
          Center(
            child: Text(
              'الاجمالي',
              textAlign: TextAlign.start,
            ),
          ),
        ),
      ]);
    }
    final row = _row![index];
    return DataRow.byIndex(
        index: index,
        selected: row.selected,
        color: MaterialStateColor.resolveWith((Set<MaterialState> states) {
          if (states.contains(MaterialState.selected)) {
            return Theme.of(context).colorScheme.primary;
          }

          return Theme.of(context).colorScheme.onPrimary;
        }),
        cells: [
          DataCell(
              Center(
                child: IconButton(
                  //style: Theme.of(context).elevatedButtonTheme.style,
                  icon: const Icon(Icons.edit_attributes),
                  // behavior: HitTestBehavior.deferToChild,
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: ((context) => MyEditDialog(
                          title: 'حدد البيانات التي تريد تعديلها',
                          content: data[index])),
                    );
                    // print('tabbed');
                  },
                ),
              ),
              //showEditIcon: true,
              onTap: () {}),
          DataCell(Center(
            child: Text(
              row.note.toString(),
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.start,
            ),
          )),
          DataCell(Center(child: Text(row.outCarton.toString()))),
          DataCell(Center(child: Text(row.outTray.toString()))),
          DataCell(Center(child: Text(row.prodCarton.toString()))),
          DataCell(Center(child: Text(row.prodTray.toString()))),
          DataCell(Center(child: Text(row.intakFeed.toString()))),
          DataCell(Center(child: Text(row.incomFeed.toString()))),
          DataCell(Center(child: Text(row.death.toString()))),
          DataCell(
            Center(
              child: Text(
                row.amberId.toString(),
                textAlign: TextAlign.start,
              ),
            ),
          ),
        ]

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
