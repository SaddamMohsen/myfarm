import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:myfarm/features/common/domain/failure.dart';

import 'package:myfarm/features/production/domain/entities/dailydata.dart';
import 'package:myfarm/features/production/domain/entities/items_movement.dart';

//enum states { Success, Error }

class Amber {
  final int id;
  final bool completed;
  const Amber({required this.id, this.completed = false});

  Amber copyWith({
    int? id,
    bool? completed,
  }) =>
      Amber(id: id ?? this.id, completed: completed ?? this.completed);
}

class Item {
  final String itemCode;
  final String itemName;
  Item({required this.itemCode, required this.itemName});
  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      itemCode: json['item_code'],
      itemName: json['item_name'],
    );
  }
}

abstract class FarmRepository {
  // const AmberRepository({required this.auth});
  // final <T> auth;

  ///This get the count of ambers to Create a list of them from farm table in database
  Future<List<Amber>> fetchAmbers();

  ///fetch the items name and code from item table in database
  Future<List<Item>> getItemsName();

  ///Add the daily data of speciefied Amber into the production table in database
  Future<Either<Failure, DailyDataModel>> addDailyData(
      {required DailyDataModel todayData});

//add out items into item_movement table in database
  Future<void> insertOutItems({required List<ItemsMovement> itemsData});

  ///Get the Daily Data of speceified date from production table DataBase
  Future<List<DailyDataModel>> getProductionData({required DateTime prodDate});

  ///update the production for speciefic date
  ///todayData is the json data to be updated
  ///rowId is the id of row in production table in database
  Future<Either<Failure, DailyDataModel>> updateDailyData(
      {required DailyDataModel todayData, required int rowId});
}

class FackAmbersRepository implements FarmRepository {
  final int _noOfAmber = 6;
  @override
  Future<List<Amber>> fetchAmbers() async {
    List<Amber> amList = [];

    amList = await Future.delayed(
      const Duration(seconds: 5),
      () => [for (var i = 1; i <= _noOfAmber; i++) Amber(id: i)].toList(),
    ).then((List<Amber> value) => value);

    return amList;
  }

  @override
  Future<void> insertOutItems({required List<ItemsMovement> itemsData}) {
    throw UnimplementedError();
  }

  @override
  Future<List<Item>> getItemsName() {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, DailyDataModel>> addDailyData(
      {required DailyDataModel todayData}) async {
    debugPrint('inside AddDailyData');
    throw UnimplementedError();
    // print(todayData);
    //print(ambId);
    // ignore: unnecessary_null_comparison
    // if (todayData.prodDate != null) {
    //   return states.Success;
    // } else {
    //   return states.Error;
    // }
  }

  @override
  Future<Either<Failure, DailyDataModel>> updateDailyData(
      {required DailyDataModel todayData, required int rowId}) {
    throw UnimplementedError();
  }

  @override
  Future<List<DailyDataModel>> getProductionData(
      {required DateTime prodDate}) async {
    var data = <String, dynamic>{
      'amberId': 3,
      'prodDate': DateTime.now(),
      'prodTray': 0,
      'prodCarton': 0,
      'outEggsTray': 0,
      'outEggsCarton': 0,
      'incomeFeed': 1,
      'intakFeed': 2.0
    };
    await Future.delayed(
      const Duration(seconds: 5),
      () => DailyDataModel.fromJson(data),
    ).then((value) => value);
    //return DailyDataModel.fromJson(data);
    return [];
  }

  //@override
  // String toString() => "$states";
}

//Firebase implementation of AmberRepository
/*class FirebaseAmbersRepository implements AmberRepository {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  int _noOfAmber = 0;
  @override
  Future<List<Amber>> fetchAmbers() async {
    debugPrint('inside loadAmbers');
    List<Amber> amList = [];

    try {
      DocumentSnapshot ambers =
          await firebaseFirestore.collection('Ambers').doc('No_of_Amber').get();

      _noOfAmber = ambers.get('no_of_amber');

      amList = [for (var i = 1; i <= _noOfAmber; i++) Amber(id: i)].toList();
    } catch (e) {
      printError();
      Get.showSnackbar(const GetSnackBar(
          titleText: Text(
        'خطأ بالاتصال بقاعدة البيانات',
      )));
      //print('Error in fetching from firebase' + e.toString());
    }

    return amList;
  }

  @override
  Future<String> addDailyData(
      {required DailyDataModel todayData, required int ambId}) async {
    String respone;
    try {
      respone = 'may success';
      await firebaseFirestore
          .collection('DailyData')
          .add(todayData.toJson())
          .then((value) => {
                respone = value.toString(),
                Indicator.closeLoading()
                /* Get.showSnackbar(GetSnackBar(
                    message: 'نجاح رفع البيانات',
                    titleText: Text(
                      'تم رفع بيانات عنبر  بنجاح$ambId $value',
                    ),
                    duration:const Duration(seconds: 3),)),*/
                //  return value,
              });
      return respone;
    } catch (e) {
      Get.showSnackbar(const GetSnackBar(
          message: 'خطأ',
          titleText: Text(
            'خطأ بالرفع لقاعدة البيانات',
          )));
      return 'فشلت العملية';
    }
  }

  @override
  Future<List<DailyDataModel>> getProductionData(
      {required DateTime prodDate, required int ambId}) async {
    List<DailyDataModel> listData = [];
    await firebaseFirestore
        .collection('DailyData')
        .where('prodDate', isEqualTo: prodDate)
        .get()
        .then(
      (querySnapshot) {
        print("Successfully completed");

        listData = querySnapshot.docs
            .map((e) => DailyDataModel.fromJson(e.data()))
            .toList();
      },
      onError: (e) => Get.showSnackbar(GetSnackBar(
          title: ' خطأ في استرجاع البيانات  ${e.printError()} ',
          messageText: const Text(
              'معذرة لم يتم الحصول على البيانات بنجاح حاول مرة أخرى'))),
    );

    return listData;
  } /*
    var data = <String, dynamic>{
      'amberId': 3,
      'prodDate': DateTime.now(),
      'prodTray': 0,
      'prodCarton': 0,
      'outEggsTray': 0,
      'outEggsCarton': 0,
      'incomeFeed': 1,
      'intakFeed': 2.0
    };
    await Future.delayed(
      const Duration(seconds: 5),
      () => DailyDataModel.fromJson(data),
    ).then((value) => value);
    return DailyDataModel.fromJson(data);
  }
*/

  @override
  String toString() => "$states";
}*/