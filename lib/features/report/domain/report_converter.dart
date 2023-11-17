import 'package:myfarm/features/report/domain/entities/dailyreport.dart';

class DailyReportConverter {
  //return dailyData as list
  static List<DailyReport> toList(dynamic data) {
    return (data as List<dynamic>)
        .map((e) => DailyReport.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  static DailyReport dailyRepToSingle(dynamic data) {
    return DailyReport.fromJson(
      (data as List).first as Map<String, dynamic>,
    );
  }
}
