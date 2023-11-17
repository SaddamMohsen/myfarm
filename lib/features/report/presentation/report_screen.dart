import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myfarm/features/report/application/amber_report_provider.dart';
import 'package:myfarm/utilities/constants.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key, required this.repDate});
  final DateTime repDate;
  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  int? dropDownvalue = 0;
  var items = [1, 2, 3];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(60.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flex(
            direction: Axis.vertical,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    width: 80,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.onBackground,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    //
                    child: DropdownButton(
                        value: dropDownvalue,
                        underline: Divider(
                          height: 5,
                          color: Theme.of(context).dividerColor,
                        ),
                        borderRadius: BorderRadius.circular(12),
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(height: 0),
                        icon: const Padding(
                          padding: EdgeInsets.only(left: 20.0),
                          child: Icon(Icons.arrow_drop_down),
                        ),
                        items: items.map<DropdownMenuItem<int>>((item) {
                          return DropdownMenuItem<int>(
                            value: item,
                            child: Text('عنبر $item'),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            dropDownvalue = value;
                          });
                        }),
                  ),
                  DropdownButton(
                      icon: Icon(Icons.arrow_drop_down),
                      items: const [
                        DropdownMenuItem<int>(
                          value: 1,
                          child: Text('1 عنبر'),
                        ),
                        DropdownMenuItem<int>(
                          value: 2,
                          child: Text('2 عنبر'),
                        ),
                        DropdownMenuItem<int>(
                          value: 3,
                          child: Text('3 عنبر'),
                        ),
                      ],
                      onChanged: (value) {}),
                  //DropdownButton(items: [], onChanged: (value) {}),
                ],
              ),
            ],
          ),
          Expanded(
            child: Consumer(
              builder: (context, ref, child) {
                final report = ref.watch(
                    AmberReportProvider(amberId: 1, repDate: widget.repDate));
                return report.when(
                  data: (data) {
                    return Text(
                      data.toString(),
                      textAlign: TextAlign.center,
                    );
                  },
                  error: (err, stackTrace) => Text(err.toString()),
                  loading: () => const CircularProgressIndicator(),
                );
              },
            ),
          ),
        ],
      ),
    ));
  }
}
