class MonthlyReport {
  final DateTime prodDate;
  final int death;
  final int incomFeed;
  final double intakFeed;
  final double reminFeed;
  final List<dynamic> prodEgg;

  final List<dynamic> outEgg;

  //String? outNote;
  final List<dynamic> remainEgg;

  const MonthlyReport(
      {required this.prodDate,
      required this.death,
      required this.incomFeed,
      required this.intakFeed,
      required this.reminFeed,
      required this.prodEgg,
      required this.outEgg,
      // this.outNote??'',
      required this.remainEgg});

  factory MonthlyReport.fromJson(Map<String, dynamic> json) {
    // json.forEach(
    //   (key, value) => print('$key :$value : ${value.runtimeType}'),
    // );

    try {
      MonthlyReport data = MonthlyReport(
          // amberId: json['amber_id'] ?? 0,
          death: json['death'],
          /*prodDate: json['prodDate'].runtimeType == Timestamp
            ? prodDateFire(json)
            : DateTime.parse(json['prodDate']), //??*/
          prodDate: DateTime.parse(json['prod_date']),
          prodEgg: json['prod_egg'],
          outEgg: json['out_egg'],
          // outTrayEggsNote: json['outTrayEggsNote'],

          //  outNote: json['outEggsNote'] ?? 'لايوجد',
          incomFeed: json['income_feed'] ?? 0.0,
          intakFeed: json['intak_feed'],
          reminFeed: json['remain_feed'],
          remainEgg: json['remain_egg']);
      return data;
    } catch (e) {
      //print(e.toString());
      throw (e.toString());
    }
    //print(data.toString());
  }

  //@override
  // String toString() =>
  //     "=>  عنبر:$amberId ,وفيات:$death,انتاج طبق:$prodTray,انتاج كرتون:$prodCarton,وارد علف:$incomFeed,مستهلك:$intakFeed,'متبقي علف:':$reminFeed,':خارج بيض':$outTray+','$outCarton,''البيض المتبقي':$remainEgg ,تفاصيل:$outNote ";
}
