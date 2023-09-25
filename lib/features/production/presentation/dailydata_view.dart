import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:json_table/json_table.dart';
import 'package:myfarm/features/production/domain/dailydata.dart';

class DailyDataView extends StatelessWidget {
  const DailyDataView({super.key, required this.data});
  final List<DailyDataModel> data;

  // final List<dynamic> dataList = List.from(data as Iterable);
  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        textDirection: TextDirection.rtl,
        //maxHeight: 900,
        //maxWidth: 300,
        children: [
          Container(
            clipBehavior: Clip.antiAlias,
            padding: EdgeInsets.symmetric(vertical: 2,horizontal: 1),
            constraints: BoxConstraints.tightForFinite(
                width: MediaQuery.of(context).size.width - 10, height: 50),
            // padding: const EdgeInsetsDirectional.all(20.0),
            decoration: BoxDecoration(
                color: Color.fromARGB(153, 238, 243, 245),
                borderRadius: BorderRadius.circular(20)),
            child: const Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                textDirection: TextDirection.rtl,
                children: [


                  Text(
                    ' الوفيات',
                    style: TextStyle(fontSize: 10.0),
                  ),

                  Text(
                    ' انتاج طبق',
                    style: TextStyle(fontSize: 8.0),
                  ),
                  Text(
                    ' انتاج كرتون',
                    style: TextStyle(fontSize: 8.0),
                  ),
                  Text(
                    ' خارج طبق',
                    style: TextStyle(fontSize: 8.0),
                  ),
                  Text(
                    ' خارج كرتون',
                    style: TextStyle(fontSize: 8.0),
                  ),
                  Text(
                    ' تفاصيل الخارج',
                    style: TextStyle(fontSize: 8.0),
                  ),
                ]),
          ),
          Expanded(
            child: ListView.builder(
                //padding: const EdgeInsets.only(right: 20.0),
                itemCount: data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    decoration: BoxDecoration(
                        color: Color.fromARGB(153, 238, 243, 245),
                        borderRadius: BorderRadius.circular(20)),
                    //constraints: BoxConstraints.expand(width: 100, height: 50),
                    //height: 50,
                    padding: const EdgeInsetsDirectional.all(5.0),
                    //
                    //decoration: BoxDecoration(border: BoxBorder(),  ),
                    child: Column(
                      children:[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          textDirection: TextDirection.rtl,
                          children: [
                            Card(
                              elevation:5,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Text(
                                      'رقم العنبر',
                                      style: TextStyle(fontSize: 9.0),
                                    ),
                                    Divider(thickness: 2,color: Colors.lightBlueAccent,),
                                    Text(
                                      ' ${data[index].amberId}',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Card(
                              elevation:5,
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Column(
                                  children: [
                                    Text(
                                      'الوفيات',
                                      style: TextStyle(fontSize: 8.0),
                                    ),
                                    Divider(thickness: 2,color: Colors.lightBlueAccent,),
                                Text(' ${data[index].death}',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            Card(
                              elevation:5,
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
                                        ' وارد علف',
                                        style: TextStyle(fontSize: 8.0),
                                      ),
                                      SizedBox(width: 2,),
                                      Text(
                                        'مستهلك',
                                        style: TextStyle(fontSize: 8.0),
                                      ),
                                      ],),
                                      Divider(thickness: 2,color: Colors.lightBlueAccent,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        //crossAxisAlignment:CrossAxisAlignment.stretch,
                                        mainAxisSize: MainAxisSize.max,
                                        textDirection: TextDirection.rtl,
                                        verticalDirection: VerticalDirection.down,
                                        children: [
                                          Text(' ${data[index].incomFeed}'),
                                          SizedBox(width: 15,),
                                          //Divider(thickness: 2,color: Colors.lightBlueAccent,),
                                          Text(' ${data[index].intakFeed}'),
                                        ],
                                      ),

                              ],
                                      ),
                                ),

                            ),

                            Card(
                              elevation:5,
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
                                          ' انتاج طبق',
                                          style: TextStyle(fontSize: 8.0),
                                        ),
                                        SizedBox(width: 2,),
                                        Text(
                                          'انتاج كرتون',
                                          style: TextStyle(fontSize: 8.0),
                                        ),
                                      ],),
                                    Divider(thickness: 2,color: Colors.lightBlueAccent,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      mainAxisSize: MainAxisSize.min,
                                      textDirection: TextDirection.rtl,
                                      verticalDirection: VerticalDirection.down,
                                      children: [
                                        Text(' ${data[index].prodTray}'),
                                        SizedBox(width: 15,),
                                        Divider(thickness: 10,color: Colors.lightBlueAccent,height: 1,),
                                        Text(' ${data[index].prodCarton}'),
                                      ],
                                    ),

                                  ],
                                ),
                              ),

                            ),



                  ]),
     Row(
       mainAxisAlignment: MainAxisAlignment.center,
       crossAxisAlignment: CrossAxisAlignment.center,
       textDirection: TextDirection.rtl,
       children: [
         Card(
           elevation:5,
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
                                              ' الخارج طبق',
                                              style: TextStyle(fontSize: 8.0),
                                            ),
                                            SizedBox(width: 2,),
                                            Text(
                                              'الخارج كرتون',
                                              style: TextStyle(fontSize: 8.0),
                                            ),
                                          ],),
                                        Divider(thickness: 2,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          mainAxisSize: MainAxisSize.min,
                                          textDirection: TextDirection.rtl,
                                          verticalDirection: VerticalDirection.down,
                                          children: [
                                            Text(' ${data[index].outEggsTray}'),
                                            SizedBox(width: 20,),
                                            Divider(thickness: 2,color: Colors.lightBlueAccent,),
                                            Text(' ${data[index].outEggsCarton}'),
                                          ],
                                        ),

                                      ],
                                    ),
                                  ),

                                ),
         Card(
           elevation:5,
           child: Padding(
             padding: const EdgeInsets.all(5.0),
             child: Column(
               children: [
                 Text(
                   'تفاصيل الخارج',
                   style: TextStyle(fontSize: 8.0),
                 ),
                 Divider(thickness: 2,color: Colors.lightBlueAccent,),
             Text(' ${data[index].outEggsNote}',
                   style: TextStyle(color: Colors.black,fontSize: 8.0),
                 ),
               ],
             ),
           ),
         ),

       ],
     ),



                 ]),
                  );
                }),
          ),
        ]);
  }
}