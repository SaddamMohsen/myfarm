import 'dart:ffi';

class DailyDataModel {
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
      {required this.prodDate,
      required this.prodTray,
      required this.prodCarton,
      required this.outEggsTray,
      //required this.outTrayEggsNote,
      required this.outEggsCarton,
      required this.outEggsNote,
      required this.incomFeed,
      required this.intakFeed,
      required this.death,
      required this.incomTrays,
      required this.incomCartoons,
      required this.outBags,
      required this.outBagsNote});

  factory DailyDataModel.fromJson(Map<String, dynamic> json) {
    //print(' in factory $json');

    return DailyDataModel(
      prodDate: json['prodDate'],
      prodTray: json['prodTray'],
      prodCarton: json['prodCarton'],
      outEggsTray: json['outEggsTray'],
      // outTrayEggsNote: json['outTrayEggsNote'],
      outEggsCarton: json['outEggsCartoon'],
      outEggsNote: json['outEggsNote'],
      incomFeed: json['incomFeed'],
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
      'prodDate': prodDate,
      'prodTray': prodTray,
      'prodCarton': prodCarton,
      if (outEggsTray != null) 'outEggsTray': outEggsTray,
      if (outEggsCarton != null) 'outEggsCarton': outEggsCarton,
      if (outEggsNote != null) 'outEggsNote': outEggsNote,
      if (incomFeed != null) 'incomFeed ': incomFeed,
      'intakFeed': intakFeed,
      if (death != null) 'death': death,
      if (incomTrays != null) 'incomTrays': incomTrays,
      if (incomCartoons != null) 'incomCartoons': incomCartoons,
      if (outBags != null) 'outBags': outBags,
      if (outBagsNote != null) 'outBagsNote': outBagsNote,
    };
  }
}
