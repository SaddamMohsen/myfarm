//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DailyDataModel {
  int?
      trId; //the number of row in production table in database used for update only
  int? farmId; //the id of the farm in farm table
  final int amberId; // the number of amber in database
  final DateTime prodDate; //date of production
  late int? prodTray; //production of eggs in trays
  late int? prodCarton; //production of eggs in cartoons
  final int? incomFeed; //income feeds today
  late double intakFeed; //intake feeds today
  final int? death; // no of death birds
  //final int? incomTrays; //no of incoming trays
  //final int? incomCartoons; //no of incoming cartoons
  final int? outEggsTray; // no of eggs in trays get out
  //final String? outTrayEggsNote; //who take the out trays
  final int? outEggsCarton; // no of eggs cartons get out
  final String? outEggsNote; //who take the out cartons
  //final int? outBags;
  //final String? outBagsNote;

  DailyDataModel({
    this.trId,
    required this.amberId,
    required this.prodDate,
    required this.prodTray,
    required this.prodCarton,
    this.outEggsTray,
    //required this.outTrayEggsNote,
    this.outEggsCarton,
    required this.outEggsNote,
    required this.incomFeed,
    required this.intakFeed,
    this.death,
    // this.incomTrays,
    //this.incomCartoons,
    //this.outBags,
    //this.outBagsNote
  });

  ///function to convert TimeStamp into DateTime
  /*static DateTime prodDateFire(Map<String, dynamic> document) {
    Timestamp t = document['prodDate'];
    DateTime d = t.toDate();

    return d;
  }*/

  factory DailyDataModel.fromJson(Map<String, dynamic> json) {
    // json.forEach(
    //   (key, value) => print('$key :$value : ${value.runtimeType}'),
    // );
    try {
      return DailyDataModel(
        amberId: json['amber_id'] ?? 0,
        /*prodDate: json['prodDate'].runtimeType == Timestamp
            ? prodDateFire(json)
            : DateTime.parse(json['prodDate']), //??*/
        prodDate: json['prodDate'],
        prodTray: json['prodTray'] ?? 0,
        prodCarton: json['prodCarton'] ?? 0,
        outEggsTray: json['outTray'] ?? 0,
        // outTrayEggsNote: json['outTrayEggsNote'],
        outEggsCarton: json['outCarton'] ?? 0,
        outEggsNote: json['outEggsNote'] ?? '',
        incomFeed: json['incom_feed'] ?? 0,
        intakFeed: json['intak_feed'] ?? 0.0,
        death: json['death'] ?? 0,
        //incomTrays: json['incomTrays'] ?? 0,
        //incomCartoons: json['incomCartoons'] ?? 0,
        //outBags: json['outBags'],
        //outBagsNote: json['outBagsNote'],
      );
    } catch (e) {
      debugPrintStack();
      print('error in convert from json ${e.toString()}');
    }
    return DailyDataModel(
      amberId: json['amber_Id'],
      prodDate: json['prodDate'],
      prodTray: json['prodTray'],
      prodCarton: json['prodCarton'],
      outEggsTray: json['outTray'],
      // outTrayEggsNote: json['outTrayEggsNote'],
      outEggsCarton: json['outCartoon'],
      outEggsNote: json['outEggsNote'],
      incomFeed: json['incom_feed'],
      intakFeed: json['intak_feed'],
      death: json['death'],
      //incomTrays: json['incomTrays'],
      //incomCartoons: json['incomCartoons'],
      //outBags: json['outBags'],
      //outBagsNote: json['outBagsNote'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'amber_id': amberId,
      'prodDate': prodDate,
      'prodTray': prodTray,
      'prodCarton': prodCarton,
      if (outEggsTray != 0) 'outTray': outEggsTray,
      if (outEggsCarton != 0) 'outCarton': outEggsCarton,
      if (outEggsNote != null) 'outEggsNote': outEggsNote,
      if (incomFeed != 0) 'incom_feed ': incomFeed,
      'intak_feed': intakFeed,
      if (death != 0) 'death': death,
      //if (incomTrays != 0) 'incomTrays': incomTrays,
      //if (incomCartoons != 0) 'incomCartoons': incomCartoons,
      //if (outBags != null) 'outBags': outBags,
      //if (outBagsNote != null) 'outBagsNote': outBagsNote,
    };
  }

  factory DailyDataModel.fromSupabaseJson(Map<String, dynamic> json) {
    // json.forEach(
    //   (key, value) => print('$key :$value : ${value.runtimeType}'),
    // );
    json['intak_feed'] = json['intak_feed'].toString();

    json.remove('farm_id');
    json.remove('created_at');
    try {
      DailyDataModel data = DailyDataModel(
        // farmId: json['farm_id'],
        trId: json['id'],
        amberId: json['amber_id'] ?? 0,
        /*prodDate: json['prodDate'].runtimeType == Timestamp
            ? prodDateFire(json)
            : DateTime.parse(json['prodDate']), //??*/
        prodDate: DateTime.parse(json['prodDate']),
        prodTray: json['prodTray'] ?? 0,
        prodCarton: json['prodCarton'] ?? 0,
        outEggsTray: json['outTray'] ?? 0,
        // outTrayEggsNote: json['outTrayEggsNote'],
        outEggsCarton: json['outCarton'] ?? 0,
        outEggsNote: json['outEggsNote'] ?? 'لايوجد',
        incomFeed: json['incom_feed'] ?? 0,
        intakFeed: double.parse(json['intak_feed']),
        death: json['death'] ?? 0,
        //incomTrays: json['incomTrays'] ?? 0,
        //incomCartoons: json['incomCartoons'] ?? 0,
        //outBags: json['outBags'],
        //outBagsNote: json['outBagsNote'],
      );
      return data;
    } catch (e) {
      //print(e.toString());
      throw (e.toString());
    }
    //print(data.toString());
  }

  Map<String, dynamic> toSupabasJson() {
    return {
      'amber_id': amberId,
      'prodDate': toTimestampString(prodDate.toString()),
      if (incomFeed != 0) 'incom_feed ': incomFeed,
      'intak_feed': intakFeed,
      'prodTray': prodTray,
      'prodCarton': prodCarton,
      if (outEggsTray != 0) 'outTray': outEggsTray,
      if (outEggsCarton != 0) 'outCarton': outEggsCarton,
      if (outEggsNote != null) 'outEggsNote': outEggsNote,
      if (death != 0) 'death': death,
      //if (incomTrays != 0) 'incomTrays': incomTrays,
      //if (incomCartoons != 0) 'incomCartoons': incomCartoons,
      //if (outBags != null) 'outBags': outBags,
      //if (outBagsNote != null) 'outBagsNote': outBagsNote,
    };
  }

/*  static Map<String, dynamic> toJsonlist(data) {
    return {
      'amberId': data.amberId,
      'prodDate': data.prodDate,
      'prodTray': data.prodTray,
      'prodCarton': data.prodCarton,
      if (data.outEggsTray != 0) 'outEggsTray': data.outEggsTray,
      if (data.outEggsCarton != 0) 'outEggsCarton': data.outEggsCarton,
      if (data.outEggsNote != null) 'outEggsNote': data.outEggsNote,
      if (data.incomFeed != 0) 'incomeFeed ': data.incomFeed,
      'intakFeed': data.intakFeed,
      if (data.death != 0) 'death': data.death,
      if (data.incomTrays != 0) 'incomTrays': data.incomTrays,
      if (data.incomCartoons != 0) 'incomCartoons': data.incomCartoons,
      if (data.outBags != null) 'outBags': data.outBags,
      if (data.outBagsNote != null) 'outBagsNote': data.outBagsNote,
    };
  }
  */
  @override
  String toString() =>
      "$prodDate=>  عنبر:$amberId ,وفيات:$death,انتاج طبق:$prodTray,انتاج كرتون:$prodCarton,وارد علف:$incomFeed,مستهلك:$intakFeed,:خارج بيض:$outEggsTray,تفاصيل:$outEggsNote ";
}
