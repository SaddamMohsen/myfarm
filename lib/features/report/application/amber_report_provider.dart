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

@riverpod
Future<DailyReport> amberReport(AmberReportRef ref,
    {required int amberId, required DateTime repDate}) {
  final repository = ref.watch(reportRepositoryProvider);
  return repository.getDailyRepByAmber(amberId, repDate);
}
