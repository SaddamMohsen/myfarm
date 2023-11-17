class DailyReport {
  final int amberId;
  final int death;
  final int incomFeed;
  final double intakFeed;
  final double reminFeed;
  final int prodTray;
  final int prodCarton;
  final int outTray;
  final int outCarton;
  final String outNote;
  final List<dynamic> remainEgg;

  const DailyReport(
      {required this.amberId,
      required this.death,
      required this.incomFeed,
      required this.intakFeed,
      required this.reminFeed,
      required this.prodCarton,
      required this.prodTray,
      required this.outCarton,
      required this.outTray,
      required this.outNote,
      required this.remainEgg});

  factory DailyReport.fromJson(Map<String, dynamic> json) {
    json.forEach(
      (key, value) => print('$key :$value : ${value.runtimeType}'),
    );

    try {
      DailyReport data = DailyReport(
          amberId: json['amber_id'] ?? 0,
          death: json['death'],
          /*prodDate: json['prodDate'].runtimeType == Timestamp
            ? prodDateFire(json)
            : DateTime.parse(json['prodDate']), //??*/
          // prodDate: DateTime.parse(json['prodDate']),
          prodTray: json['prodTray'] ?? 0,
          prodCarton: json['prodCarton'] ?? 0,
          outTray: json['outTray'] ?? 0,
          // outTrayEggsNote: json['outTrayEggsNote'],
          outCarton: json['outCarton'] ?? 0,
          outNote: json['outEggsNote'] ?? 'لايوجد',
          incomFeed: json['incom_feed'] ?? 0.0,
          intakFeed: json['intak_feed'],
          reminFeed: json['remain_feed'],
          remainEgg: json['reminegg']);
      return data;
    } catch (e) {
      print(e.toString());
      throw (e.toString());
    }
    //print(data.toString());
  }

  @override
  String toString() =>
      "=>  عنبر:$amberId ,وفيات:$death,انتاج طبق:$prodTray,انتاج كرتون:$prodCarton,وارد علف:$incomFeed,مستهلك:$intakFeed,'متبقي علف:':$reminFeed,':خارج بيض':$outTray+','$outCarton,''البيض المتبقي':$remainEgg ,تفاصيل:$outNote ";
}
