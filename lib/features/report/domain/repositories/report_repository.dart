import 'package:myfarm/features/report/domain/entities/amber_month_report.dart';
import 'package:myfarm/features/report/domain/entities/dailyreport.dart';
import 'package:myfarm/features/report/domain/entities/monthlyreport.dart';

abstract class ReportRepository {
  Future<DailyReport> getDailyRepByAmber(int amberId, DateTime repDate);
  Future<List<DailyReport>> getDailyRepByFarm(DateTime repDate);
  Future<List<MonthlyReport>> getMonthlyRepByFarm(DateTime repDate);
  Future<List<AmberMonthlyReport>> getMonthlyRepByAmber(
      int amberId, DateTime intoDate);
}
