import 'package:myfarm/features/production/data/supabase_amber_repository.dart';
import 'package:myfarm/features/production/domain/dailydata.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:myfarm/features/authentication/presentation/supabase_auth_provider.dart';
//import 'package:supabase_flutter/supabase_flutter.dart';

part 'add_production_notifier.g.dart';

final productionRepositoryProvider =
    Provider.autoDispose((ref){
         final user=ref.watch(supaAuthRepProvider)
        .currentUser;
         if(user ==null)
           throw AssertionError('user can\'t be null ');
         return SupabaseAmbersRepository(supabaseClient: ref.watch(supabaseClientProvider),user:user);
    }
    );
final productionProvider =
    FutureProvider.autoDispose.family<void, dynamic>((ref, todayData) {
  //print('inside productionRepository');
  final repository = ref.watch(productionRepositoryProvider);
  final farmId=ref.watch(productionRepositoryProvider).user.userMetadata?['farmId'];
  return repository.addDailyData(todayData: todayData);
});

@riverpod
class AddProductionController extends _$AddProductionController {
  @override
  FutureOr<void> build() {}

  Future<bool> addDailyData(DailyDataModel todayData) async {
    final productionRepository = ref.read(productionRepositoryProvider);
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() =>
        productionRepository.addDailyData(todayData: todayData));
    return state.hasError == true;
  }
}