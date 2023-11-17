import 'package:myfarm/config/provider.dart';
import 'package:myfarm/features/authentication/application/supabase_auth_provider.dart';
import 'package:myfarm/features/production/infrastructur/repositories/supabase_amber_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:myfarm/features/production/domain/entities/dailydata.dart';

part 'fetch_production_data.g.dart';

/// initialize the amberRepository
final repositoryProvider = Provider.autoDispose((ref) {
  final user = ref.watch(supaAuthRepProvider.select((v) => v.currentUser));
  if (user == null) throw AssertionError('لم تقم بتسجيل الدخول');

  return SupabaseAmbersRepository(
      supabaseClient: ref.watch(supabaseClientProvider), user: user);
});

//provider to fetch the data of production from database in this date
@riverpod
Future<List<DailyDataModel>> fetchProductionData(FetchProductionDataRef ref,
    {required todayDate}) async {
  final repository = ref.watch(repositoryProvider);
  return repository.getProductionData(prodDate: todayDate);
}
