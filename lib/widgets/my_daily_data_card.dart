import 'package:flutter/material.dart';
import 'package:myfarm/features/production/domain/dailydata.dart';

class MyDailyDataCard extends StatelessWidget {
  const MyDailyDataCard({super.key, required this.data});
  final DailyDataModel data;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'البيض',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            /*  Container(
              width: 100,
              height: 80,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
              child: Card(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                color: Theme.of(context).colorScheme.onPrimary,
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                'المتبقي',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              Row(
                                  textDirection: TextDirection.rtl,
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      'طبق',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      'كرتون',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                    ),
                                  ]),
                              Row(
                                  mainAxisSize: MainAxisSize.max,
                                  // mainAxisAlignment:
                                  //     MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      '2',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                    ),
                                    SizedBox(
                                      width: 25,
                                    ),
                                    Text(
                                      '5',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                    ),
                                  ]),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
           */
            eggCard(context, 'الخارج', data.outEggsTray.toString(),
                data.outEggsCarton.toString()),
            eggCard(context, 'الانتاج', data.prodTray.toString(),
                data.prodCarton.toString()),
          ],
        ),
      ],
    );
  }

  Container eggCard(
      BuildContext context, String title1, String data1, String data2) {
    return Container(
      width: 100,
      height: 80,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onPrimary,
      ),
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        color: Theme.of(context).colorScheme.onPrimary,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title1,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        textDirection: TextDirection.rtl,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'طبق',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'كرتون',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
                        ]),
                    Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        textDirection: TextDirection.rtl,
                        children: [
                          Text(
                            data1.toString(),
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          SizedBox(
                            width: 25,
                          ),
                          Text(
                            data2.toString(),
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ]),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
