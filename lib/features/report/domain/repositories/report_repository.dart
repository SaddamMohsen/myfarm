import 'package:myfarm/features/report/domain/entities/dailyreport.dart';

abstract class ReportRepository {
  Future<DailyReport> getDailyRepByAmber(int amberId, DateTime repDate);
}
