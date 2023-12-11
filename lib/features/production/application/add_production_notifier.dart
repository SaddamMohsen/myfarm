import 'package:myfarm/features/common/application/network_provider.dart';
import 'package:myfarm/features/home/application/fetch_production_data.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:myfarm/features/authentication/application/supabase_auth_provider.dart';
import 'package:myfarm/features/production/infrastructur/repositories/supabase_amber_repository.dart';
import 'package:myfarm/features/production/domain/entities/dailydata.dart';
import 'package:myfarm/config/provider.dart';
//import 'package:supabase_flutter/supabase_flutter.dart';

part 'add_production_notifier.g.dart';

final productionRepositoryProvider = Provider.autoDispose((ref) {
  // final internetConnection = ref.watch(networkAwareProvider.notifier).stream;
  // print('check net in amber repo ${internetConnection}');
  // if ( internetConnection.contains(NetworkStatus.Off)) {
  //   throw AssertionError('لا يوجد اتصال انترنت');
  // }
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
  FutureOr<DailyDataModel?> build() {
    return null;
  }

  // Future<List<DailyDataModel>> fetchProductionData(DateTime todayDate) async {
  //   final repository = ref.watch(productionRepositoryProvider);
  //   try {
  //     state = AsyncData(repository.getProductionData(prodDate: todayDate)
  //         as List<DailyDataModel>);
  //     print('in State $state');
  //   } catch (e, stackTrace) {
  //     state = AsyncValue.error(e, stackTrace);
  //   }
  //   //return state;
  //   //Future<List<DailyDataModel>> newData = AsyncValue.data(state.value);
  // }

  Future<void> addDailyData(DailyDataModel todayData) async {
    //final items = state.valueOrNull ?? [];
    final productionRepository = ref.read(productionRepositoryProvider);
    state = const AsyncValue.loading();

    final res = await productionRepository.addDailyData(todayData: todayData);

    state = res.fold((l) => AsyncValue.error(l.error, StackTrace.current),
        (r) => AsyncValue.data(r));

    // return state.hasError;
    // == true;
  }

  Future<void> updateDailyData(DailyDataModel todayData, int rowId) async {
    // final items = state.valueOrNull ?? [];
    final productionRepository = ref.read(productionRepositoryProvider);
    state = const AsyncValue.loading();

    final res = await productionRepository.updateDailyData(
        todayData: todayData, rowId: rowId);
    state = res.fold((l) => AsyncValue.error(l.error, StackTrace.current),
        (r) => AsyncValue.data(r));
  }
}
