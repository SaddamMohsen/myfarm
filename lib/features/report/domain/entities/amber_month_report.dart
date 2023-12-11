class AmberMonthlyReport {
  final DateTime prodDate;
  final int death;
  final int incomFeed;
  final double intakFeed;
  final double reminFeed;
  final int prodTray;
  final int prodCarton;

  final int outTray;
  final int outCarton;
  String? outNote;
  final List<dynamic> remainEgg;

  AmberMonthlyReport(
      {required this.prodDate,
      required this.death,
      required this.incomFeed,
      required this.intakFeed,
      required this.reminFeed,
      required this.prodTray,
      required this.prodCarton,
      required this.outTray,
      required this.outCarton,
      this.outNote,
      required this.remainEgg});

  factory AmberMonthlyReport.fromJson(Map<String, dynamic> json) {
    json.forEach(
      (key, value) => print('$key :$value : ${value.runtimeType}'),
    );

    try {
      AmberMonthlyReport data = AmberMonthlyReport(
          prodDate: DateTime.parse(json['prod_date']),
          death: json['death'] ?? 0,
          incomFeed: json['income_feed'] ?? 0.0,
          intakFeed: double.parse(json['intak_feed'].toString()),
          reminFeed: json['remain_feed'] ?? 0.0,
          /*prodDate: json['prodDate'].runtimeType == Timestamp
            ? prodDateFire(json)
            : DateTime.parse(json['prodDate']), //??*/

          prodTray: json['prod_tray'] ?? 0,
          prodCarton: json['prod_carton'] ?? 0,
          outTray: json['out_tray'] ?? 0,
          outCarton: json['out_carton'] ?? 0,
          outNote: json['out_note'] ?? 'لايوجد',
          remainEgg: json['remain_egg']);
      return data;
    } catch (e) {
      print(e.toString());
      throw (e.toString());
    }
  }
}
