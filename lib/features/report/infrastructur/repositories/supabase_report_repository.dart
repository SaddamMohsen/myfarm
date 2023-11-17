import 'package:myfarm/features/common/domain/failure.dart';
import 'package:myfarm/features/report/domain/entities/dailyreport.dart';
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
      "repdate": repDate.toIso8601String()
    };
    final DailyReport data;
    try {
      data = await supabaseClient
          .rpc('get_daily_report', params: param)
          .withConverter((data) => DailyReportConverter.dailyRepToSingle(data));

      return Future.value(data);
    } on PostgrestException catch (e) {
      throw const Failure.badRequest();
    } catch (e) {
      throw e.toString();
    }
  }
}
