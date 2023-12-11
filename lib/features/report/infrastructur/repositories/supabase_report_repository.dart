import 'package:myfarm/features/common/domain/failure.dart';
import 'package:myfarm/features/report/domain/entities/amber_month_report.dart';
import 'package:myfarm/features/report/domain/entities/dailyreport.dart';
import 'package:myfarm/features/report/domain/entities/monthlyreport.dart';
import 'package:myfarm/features/report/domain/report_converter.dart';
import 'package:myfarm/features/report/domain/repositories/report_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseReportRepository extends ReportRepository {
  SupabaseReportRepository({required this.supabaseClient, required this.user})
      : super();
  final SupabaseClient supabaseClient;
  final User user;

  ///function to get daily report for specific amber
  @override
  Future<DailyReport> getDailyRepByAmber(int amberId, DateTime repDate) async {
    final int farmId = user.userMetadata?['farm_id'];

    final Map<String, dynamic> param = {
      "f_id": farmId,
      "amb_id": amberId,
      "rep_date": repDate.toIso8601String()
    };
    final DailyReport data;
    try {
      data = await supabaseClient
          .rpc('get_daily_report', params: param)
          .withConverter((data) => DailyReportConverter.dailyRepToSingle(data));

      return Future.value(data);
    } on PostgrestException catch (e) {
      throw Failure.unprocessableEntity(message: e.message);
    } catch (e) {
      throw Failure.unprocessableEntity(message: e.toString());
    }
  }

  @override
  Future<List<DailyReport>> getDailyRepByFarm(DateTime repDate) async {
    final int farmId = user.userMetadata?['farm_id'];

    final Map<String, dynamic> param = {
      "f_id": farmId,
      "amb_id": 0,
      "rep_date": repDate.toIso8601String()
    };
    final List<DailyReport> data;
    try {
      data = await supabaseClient
          .rpc('get_daily_report', params: param)
          .withConverter((data) => DailyReportConverter.toList(data));

      return Future.value(data);
    } on PostgrestException catch (e) {
      throw Failure.unprocessableEntity(message: e.message);
    } catch (e) {
      throw Failure.unprocessableEntity(message: e.toString());
    }
  }

  @override
  Future<List<MonthlyReport>> getMonthlyRepByFarm(DateTime repDate) async {
    final int farmId = user.userMetadata?['farm_id'];

    final Map<String, dynamic> param = {
      "f_id": farmId,
      "rep_date": repDate.toIso8601String()
    };
    final List<MonthlyReport> data;
    try {
      data = await supabaseClient
          .rpc('get_farm_month_report', params: param)
          .withConverter((data) => MonthlyReportConverter.toList(data));

      return Future.value(data);
    } on PostgrestException catch (e) {
      throw Failure.unprocessableEntity(message: e.message);
    } catch (e) {
      throw Failure.unprocessableEntity(message: e.toString());
    }
  }

  ///TODO get amber monthly report
  @override
  Future<List<AmberMonthlyReport>> getMonthlyRepByAmber(
      int ambId, DateTime repDate) async {
    final int farmId = user.userMetadata?['farm_id'];

    final Map<String, dynamic> param = {
      "f_id": farmId,
      'amb_id': ambId,
      "into_date": repDate.toIso8601String()
    };
    final List<AmberMonthlyReport> data;
    try {
      data = await supabaseClient
          .rpc('get_amber_monthly_report', params: param)
          .withConverter((data) => AmberMonthlyReportConverter.toList(data));

      return Future.value(data);
    } on PostgrestException catch (e) {
      throw Failure.unprocessableEntity(message: e.message.toString());
    } catch (e) {
      // print(e.toString());
      throw Failure.unprocessableEntity(message: e.toString());
    }
  }
}
