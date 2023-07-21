class DailyDataModel {
  final DateTime date;
  late int prodTray; //production of eggs in trays
  late int prodCarton; //production of eggs in cartoons
  final int? incomFeed; //income feeds today
  late int intakFeed; //intake feeds today
  final int? death; // no of death birds
  final int? incomTrays; //no of incoming trays
  final int? incomCartoons; //no of incoming cartoons
  final int? outEggsTray; // no of eggs in trays get out
  final String? outTrayEggsNote; //who take the out trays
  final int? outCartonEggs; // no of eggs cartons get out
  final String? outCartonEggsNote; //who take the out cartons
  final int? outBags;
  final String? outBagsNote;

  DailyDataModel(
      {required this.date,
      required this.prodTray,
      required this.prodCarton,
      required this.outEggsTray,
      required this.outTrayEggsNote,
      required this.outCartonEggs,
      required this.outCartonEggsNote,
      required this.incomFeed,
      required this.intakFeed,
      required this.death,
      required this.incomTrays,
      required this.incomCartoons,
      required this.outBags,
      required this.outBagsNote});
  factory DailyDataModel.fromJson(Map<String, dynamic> json) {
    return DailyDataModel(
      date: json['date'],
      prodTray: json['prodTray'],
      prodCarton: json['prodCarton'],
      outEggsTray: json['outEggsTray'],
      outTrayEggsNote: json['outTrayEggsNote'],
      outCartonEggs: json['outCartonEggs'],
      outCartonEggsNote: json['outCartonEggsNote'],
      incomFeed: json['incomFeed'],
      intakFeed: json['intakFeed'],
      death: json['death'],
      incomTrays: json['incomTrays'],
      incomCartoons: json['incomCartoons'],
      outBags: json['outBags'],
      outBagsNote: json['outBagsNote'],
    );
  }
}
