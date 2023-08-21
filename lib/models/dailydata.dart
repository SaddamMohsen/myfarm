import 'dart:ffi';

import 'package:flutter/material.dart';

class DailyDataModel {
  final int amberId;
  final DateTime prodDate;
  late int? prodTray; //production of eggs in trays
  late int? prodCarton; //production of eggs in cartoons
  final int? incomFeed; //income feeds today
  late double intakFeed; //intake feeds today
  final int? death; // no of death birds
  final int? incomTrays; //no of incoming trays
  final int? incomCartoons; //no of incoming cartoons
  final int? outEggsTray; // no of eggs in trays get out
  //final String? outTrayEggsNote; //who take the out trays
  final int? outEggsCarton; // no of eggs cartons get out
  final String? outEggsNote; //who take the out cartons
  final int? outBags;
  final String? outBagsNote;

  DailyDataModel(
      {required this.amberId,
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
      this.incomTrays,
      this.incomCartoons,
      this.outBags,
      this.outBagsNote});

  factory DailyDataModel.fromJson(Map<String, dynamic> json) {
    try {
      return DailyDataModel(
        amberId: json['amberId'] ?? 0,
        prodDate: json['prodDate'],
        prodTray: json['prodTray'] ?? 0,
        prodCarton: json['prodCarton'] ?? 0,
        outEggsTray: json['outEggsTray'] ?? 0,
        // outTrayEggsNote: json['outTrayEggsNote'],
        outEggsCarton: json['outEggsCartoon'] ?? 0,
        outEggsNote: json['outEggsNote'] ?? 'لايوجد',
        incomFeed: json['incomeFeed'] ?? 0,
        intakFeed: json['intakFeed'] ?? 0,
        death: json['death'] ?? 0,
        incomTrays: json['incomTrays'] ?? 0,
        incomCartoons: json['incomCartoons'] ?? 0,
        outBags: json['outBags'],
        outBagsNote: json['outBagsNote'],
      );
    } catch (e) {
      debugPrintStack();
    }
    return DailyDataModel(
      amberId: json['amberId'],
      prodDate: json['prodDate'],
      prodTray: json['prodTray'],
      prodCarton: json['prodCarton'],
      outEggsTray: json['outEggsTray'],
      // outTrayEggsNote: json['outTrayEggsNote'],
      outEggsCarton: json['outEggsCartoon'],
      outEggsNote: json['outEggsNote'],
      incomFeed: json['incomeFeed'],
      intakFeed: json['intakFeed'],
      death: json['death'],
      incomTrays: json['incomTrays'],
      incomCartoons: json['incomCartoons'],
      outBags: json['outBags'],
      outBagsNote: json['outBagsNote'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'amberId': amberId,
      'prodDate': prodDate,
      'prodTray': prodTray,
      'prodCarton': prodCarton,
      if (outEggsTray != 0) 'outEggsTray': outEggsTray,
      if (outEggsCarton != 0) 'outEggsCarton': outEggsCarton,
      if (outEggsNote != null) 'outEggsNote': outEggsNote,
      if (incomFeed != 0) 'incomeFeed ': incomFeed,
      'intakFeed': intakFeed,
      if (death != 0) 'death': death,
      if (incomTrays != 0) 'incomTrays': incomTrays,
      if (incomCartoons != 0) 'incomCartoons': incomCartoons,
      if (outBags != null) 'outBags': outBags,
      if (outBagsNote != null) 'outBagsNote': outBagsNote,
    };
  }
}
