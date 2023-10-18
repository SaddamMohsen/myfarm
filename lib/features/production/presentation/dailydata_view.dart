import 'package:flutter/material.dart';

import 'package:myfarm/features/production/domain/dailydata.dart';

import 'package:myfarm/widgets/my_daily_data_card.dart';
import 'package:myfarm/widgets/edit_dialog.dart';

class DailyDataView extends StatelessWidget {
  const DailyDataView({super.key, required this.data});
  final List<DailyDataModel> data;

  // final List<dynamic> dataList = List.from(data as Iterable);
  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        textDirection: TextDirection.rtl,
        crossAxisAlignment: CrossAxisAlignment.center,
        //maxHeight: 900,
        //maxWidth: 300,
        children: [
          Container(
            clipBehavior: Clip.antiAlias,
            padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 1),
            constraints: BoxConstraints.tightForFinite(
                width: MediaQuery.of(context).size.width - 10, height: 50),
            // padding: const EdgeInsetsDirectional.all(20.0),
            decoration: BoxDecoration(
                color: const Color.fromARGB(153, 238, 243, 245),
                borderRadius: BorderRadius.circular(20)),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                textDirection: TextDirection.rtl,
                children: [
                  const Text(
                    ' تقرير العلف والبيض يوم ',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  Text(
                    data[0].prodDate.toString().substring(0, 11) ?? '',
                    style: const TextStyle(fontSize: 10.0),
                  ),
                ]),
          ),
          Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    // alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                        color: Color.fromARGB(153, 238, 243, 245),
                        borderRadius: BorderRadius.circular(20)),

                    padding: const EdgeInsetsDirectional.all(3.0),
                    //
                    //decoration: BoxDecoration(border: BoxBorder(),  ),
                    child: Wrap(
                        //physics: NeverScrollableScrollPhysics(),
                        crossAxisAlignment: WrapCrossAlignment.start,
                        textDirection: TextDirection.rtl,
                        direction: Axis.horizontal,
                        alignment: WrapAlignment.start,
                        // runAlignment: WrapAlignment.start,
                        //spacing: 3,
                        runSpacing: 0,
                        children: [
                          SingleChildScrollView(
                            reverse: true,
                            scrollDirection: Axis.horizontal,
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                  minWidth:
                                      MediaQuery.of(context).size.width / 2),
                              child: Wrap(
                                textDirection: TextDirection.rtl,
                                alignment: WrapAlignment.center,
                                runAlignment: WrapAlignment.center,
                                crossAxisAlignment: WrapCrossAlignment.center,
                                direction: Axis.vertical,
                                children: [
                                  ClipOval(
                                    clipBehavior: Clip.antiAlias,
                                    child: Container(
                                      height: 70,
                                      width: 60,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                      ),
                                      child: CircleAvatar(
                                        backgroundColor: Theme.of(context)
                                            .colorScheme
                                            .onSurface,
                                        radius: 100,
                                        child: Stack(
                                          //direction: Axis.vertical,
                                          // mainAxisAlignment:
                                          //     MainAxisAlignment.spaceEvenly,
                                          // crossAxisAlignment:
                                          //     CrossAxisAlignment.center,
                                          children: [
                                            const Positioned(
                                              top: 15,
                                              left: 10,
                                              width: 70,
                                              child: Text(
                                                'رقم العنبر',
                                                style:
                                                    TextStyle(fontSize: 10.0),
                                              ),
                                            ),
                                            // Divider(
                                            //   thickness: 2,
                                            //   color: Colors.lightBlueAccent,
                                            // ),
                                            Positioned(
                                              top: 30,
                                              left: 20,
                                              //width: 50,
                                              child: Center(
                                                child: Text(
                                                  ' ${data[index].amberId}',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headlineMedium
                                                      ?.copyWith(
                                                          fontSize: 20,
                                                          color: Colors.white),
                                                  textAlign: TextAlign.right,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Wrap(
                                    direction: Axis.horizontal,
                                    textDirection: TextDirection.rtl,
                                    children: [
                                      SizedBox(
                                        width: 180,
                                        height: 115,
                                        child: Card(
                                          elevation: 5,
                                          child: Column(
                                            children: [
                                              const Padding(
                                                padding: EdgeInsets.all(4.0),
                                                child: Text('العلف'),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Card(
                                                    elevation: 5,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5.0),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          const Text(
                                                            'الوفيات',
                                                            style: TextStyle(
                                                                fontSize: 8.0),
                                                          ),
                                                          const Divider(
                                                            thickness: 2,
                                                            color: Colors
                                                                .lightBlueAccent,
                                                          ),
                                                          Text(
                                                            ' ${data[index].death}',
                                                            style:
                                                                const TextStyle(
                                                                    color: Colors
                                                                        .black),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      showDialog(
                                                        context: context,
                                                        builder: ((context) =>
                                                            MyEditDialog(
                                                                title:
                                                                    'حدد البيانات التي تريد تعديلها',
                                                                content: data[
                                                                    index])),
                                                      );
                                                    },
                                                    child: MyCard(
                                                      data1: data[index]
                                                          .incomFeed
                                                          .toString(),
                                                      data2: data[index]
                                                          .intakFeed
                                                          .toString(),
                                                      title1: 'الوارد ',
                                                      title2: 'المستهلك ',
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      data.isNotEmpty
                                          ? Card(
                                              elevation: 5,
                                              child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  child: MyDailyDataCard(
                                                      data: data[index])))
                                          : SizedBox(),
                                    ],
                                  ),
                                  data[index].outEggsNote != ''
                                      ? Card(
                                          elevation: 5,
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Column(
                                              children: [
                                                const Text(
                                                  'تفاصيل الخارج',
                                                  style:
                                                      TextStyle(fontSize: 8.0),
                                                ),
                                                const Divider(
                                                  thickness: 2,
                                                  color: Colors.lightBlueAccent,
                                                ),
                                                Text(
                                                  ' ${data[index].outEggsNote}',
                                                  softWrap: true,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 8.0),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      : SizedBox.shrink(),
                                ],
                              ),
                            ),
                          ),
                        ]),
                  );
                }),
          ),
        ]);
  }
}

class MyCard extends StatelessWidget {
  const MyCard({
    super.key,
    required this.data1,
    required this.data2,
    required this.title1,
    required this.title2,
  });

  final String data1;
  final String data2;
  final String title1;
  final String title2;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              textDirection: TextDirection.rtl,
              verticalDirection: VerticalDirection.down,
              children: [
                Text(
                  title1,
                  style: TextStyle(fontSize: 10.0),
                ),
                const SizedBox(
                  width: 2,
                ),
                Text(
                  title2,
                  style: TextStyle(fontSize: 10.0),
                ),
              ],
            ),
            Divider(
              thickness: 2,
              color: Colors.lightBlueAccent,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              textDirection: TextDirection.rtl,
              verticalDirection: VerticalDirection.down,
              children: [
                Text(' ${data1}'),
                SizedBox(
                  width: 15,
                ),
                Divider(
                  thickness: 10,
                  color: Colors.lightBlueAccent,
                  height: 1,
                ),
                Text(' ${data2}'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
