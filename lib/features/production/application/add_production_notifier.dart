import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:myfarm/features/authentication/application/supabase_auth_provider.dart';
import 'package:myfarm/features/production/infrastructur/repositories/supabase_amber_repository.dart';
import 'package:myfarm/features/production/domain/entities/dailydata.dart';
import 'package:myfarm/config/provider.dart';
//import 'package:supabase_flutter/supabase_flutter.dart';

part 'add_production_notifier.g.dart';

final productionRepositoryProvider = Provider.autoDispose((ref) {
  //get the current logged in user from supaAuthprovider
  final user = ref.watch(supaAuthRepProvider).currentUser;
  if (user == null) throw AssertionError('لم تقم بتسحيل الدخول ');
  return SupabaseAmbersRepository(
      supabaseClient: ref.watch(supabaseClientProvider), user: user);
});

final productionProvider =
    FutureProvider.autoDispose.family<void, dynamic>((ref, todayData) {
  final repository = ref.watch(productionRepositoryProvider);

  return repository.addDailyData(todayData: todayData);
});

@riverpod
class AddProductionController extends _$AddProductionController {
  @override
  FutureOr<void> build() {}

  Future<bool> addDailyData(DailyDataModel todayData) async {
    final productionRepository = ref.read(productionRepositoryProvider);
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(
        () => productionRepository.addDailyData(todayData: todayData));
    return state.hasError == true;
  }

  Future<bool> updateDailyData(DailyDataModel todayData, int rowId) async {
    final productionRepository = ref.read(productionRepositoryProvider);
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() => productionRepository.updateDailyData(
        todayData: todayData, rowId: rowId));
    return state.hasError == true;
  }
}
