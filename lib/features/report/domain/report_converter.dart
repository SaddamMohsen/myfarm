import 'package:myfarm/features/report/domain/entities/amber_month_report.dart';
import 'package:myfarm/features/report/domain/entities/dailyreport.dart';
import 'package:myfarm/features/report/domain/entities/monthlyreport.dart';

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

class MonthlyReportConverter {
  //return dailyData as list
  static List<MonthlyReport> toList(dynamic data) {
    return (data as List<dynamic>)
        .map((e) => MonthlyReport.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  static MonthlyReport toSingle(dynamic data) {
    return MonthlyReport.fromJson(
      (data as List).first as Map<String, dynamic>,
    );
  }
}

class AmberMonthlyReportConverter {
  //return dailyData as list
  static List<AmberMonthlyReport> toList(dynamic data) {
    return (data as List<dynamic>)
        .map((e) => AmberMonthlyReport.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  static AmberMonthlyReport toSingle(dynamic data) {
    return AmberMonthlyReport.fromJson(
      (data as List).first as Map<String, dynamic>,
    );
  }
}
