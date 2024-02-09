import 'package:myfarm/features/production/domain/entities/items_movement.dart';
import 'package:myfarm/features/report/domain/entities/monthlyreport.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:myfarm/config/provider.dart';
import 'package:myfarm/features/authentication/application/supabase_auth_provider.dart';
import 'package:myfarm/features/report/infrastructur/repositories/supabase_report_repository.dart';

part 'farm_report_provider.g.dart';

//initialize the report repository provider
final reportRepositoryProvider = Provider.autoDispose((ref) {
  //get the current logged in user  from Authentication provider
  final user = ref.watch(supaAuthRepProvider.select((v) => v.currentUser));
  if (user == null) throw AssertionError('لم تقم بتسجيل الدخول');

  return SupabaseReportRepository(
      supabaseClient: ref.watch(supabaseClientProvider), user: user);
});

///provider that return report of all  farm by Month
@riverpod
Future<List<MonthlyReport>> monthFarmReport(MonthFarmReportRef ref,
    {required DateTime repDate}) {
  final repository = ref.watch(reportRepositoryProvider);
  return repository.getMonthlyRepByFarm(repDate);
}

///Get out Item by Farm and month and itemCode
@riverpod
Future<List<ItemsMovement>> outItemsMonthlyReportByFarm(
    OutItemsMonthlyReportByFarmRef ref,
    {required String itemCode,
    required DateTime repDate}) {
  final repository = ref.watch(reportRepositoryProvider);
  return repository.getOutItemsReportByMonthForFarm(itemCode, repDate);
}
