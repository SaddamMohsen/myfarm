import 'package:myfarm/config/provider.dart';
import 'package:myfarm/features/authentication/application/supabase_auth_provider.dart';
import 'package:myfarm/features/common/application/network_provider.dart';
import 'package:myfarm/features/production/infrastructur/repositories/supabase_amber_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:myfarm/features/production/domain/entities/dailydata.dart';

part 'fetch_production_data.g.dart';

/// initialize the amberRepository
final repositoryProvider = Provider.autoDispose((ref) {
  final internetConnection = ref.watch(networkAwareProvider);
  if (internetConnection != NetworkStatus.On) {
    throw AssertionError('لا يوجد اتصال انترنت');
  }
  final user = ref.watch(supaAuthRepProvider.select((v) => v.currentUser));
  if (user == null) throw AssertionError('لم تقم بتسجيل الدخول');

  return SupabaseAmbersRepository(
      supabaseClient: ref.watch(supabaseClientProvider), user: user);
});

//provider to fetch the data of production from database in this date
@riverpod //(keepAlive: false)
Future<List<DailyDataModel>> fetchProductionData(FetchProductionDataRef ref,
    {required todayDate}) {
  final internetConnection = ref.watch(networkAwareProvider);

  if (internetConnection != NetworkStatus.On) {
    throw UnimplementedError('لا يوجد اتصال انترنت');
  }
  final repository = ref.watch(repositoryProvider);
  return repository.getProductionData(prodDate: todayDate);
}

/*class ProductionNotifier extends StateNotifier<AsyncValue<List<DailyDataModel>>> {
  ProductionNotifier(this.ref) : super(const AsyncValue.loading()){
    
  }
 final Ref ref;
  Future<void> _fetchData(DateTime repDate) async {
    state = const AsyncValue.loading();
    try {
      
      final repository = await ref.watch(repositoryProvider).getProductionData(prodDate: repDate);
;
      final data=repository.getProductionData(prodDate: todayDate);
      state = AsyncValue.data(data);
    } catch (err, stack) {
      state = AsyncValue.error(err, stack);
    }
  }
}*/
