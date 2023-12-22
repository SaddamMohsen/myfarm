import 'package:myfarm/features/production/domain/entities/items_movement.dart';
import 'package:myfarm/features/report/domain/entities/amber_month_report.dart';
import 'package:myfarm/features/report/domain/entities/dailyreport.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:myfarm/config/provider.dart';
import 'package:myfarm/features/authentication/application/supabase_auth_provider.dart';
import 'package:myfarm/features/report/infrastructur/repositories/supabase_report_repository.dart';

part 'amber_report_provider.g.dart';

final reportRepositoryProvider = Provider.autoDispose((ref) {
  //get the current logged in user  from Authentication provider
  final user = ref.watch(supaAuthRepProvider.select((v) => v.currentUser));
  if (user == null) throw AssertionError('لم تقم بتسجيل الدخول');

  return SupabaseReportRepository(
      supabaseClient: ref.watch(supabaseClientProvider), user: user);
});

///get report for one amber only that speciefied by amberId
@riverpod
Future<DailyReport> amberReport(AmberReportRef ref,
    {required int amberId, required DateTime repDate}) {
  final repository = ref.watch(reportRepositoryProvider);
  return repository.getDailyRepByAmber(amberId, repDate);
}

///return daily report of all ambers in the farm only one day
@riverpod
Future<List<DailyReport>> farmReport(FarmReportRef ref,
    {required DateTime repDate}) {
  final repository = ref.watch(reportRepositoryProvider);
  return repository.getDailyRepByFarm(repDate);
}

///return monthly report of amber day by day
///
@riverpod
Future<List<AmberMonthlyReport>> amberMonthReport(AmberMonthReportRef ref,
    {required int amberId, required DateTime repDate}) {
  final repository = ref.watch(reportRepositoryProvider);
  return repository.getMonthlyRepByAmber(amberId, repDate);
}

///Get daily out items by ambers and type
@riverpod
Future<List<ItemsMovement>> outItemsDailyReport(OutItemsDailyReportRef ref,
    {required String itemCode,
    required int amberId,
    required DateTime repDate}) {
  final repository = ref.watch(reportRepositoryProvider);
  return repository.getOutItemsReportByDate(itemCode, amberId, repDate);
}
