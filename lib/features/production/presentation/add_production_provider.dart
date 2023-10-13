import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myfarm/features/production/data/ambers_repository.dart';
import 'package:myfarm/features/production/data/supabase_amber_repository.dart';
import 'package:myfarm/features/authentication/data/supabase_auth_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../authentication/presentation/supabase_auth_provider.dart';
import '../domain/dailydata.dart';
part 'add_production_provider.g.dart';

//provider to get the list of ambers from the database
//@Riverpod(keepAlive:true)
final amberRepositoryProvider = Provider((ref) {
  final user = ref.watch(supaAuthRepProvider).currentUser;
  if (user == null) throw AssertionError('لم تقم بتسجيل الدخول');

  return SupabaseAmbersRepository(
      supabaseClient: ref.watch(supabaseClientProvider), user: user);
});

//provider to get the list of ambers in the farm
@Riverpod(keepAlive: true)
Future<List<Amber>> fetchAmbers(FetchAmbersRef ref) async {
  final repository = ref.watch(amberRepositoryProvider);
  return repository.fetchAmbers();
}
// final amberProvider = FutureProvider.autoDispose<List<Amber>>((ref) {
//   final repository = ref.watch(amberRepositoryProvider);
//   return repository.fetchAmbers();
// });

//provider to fetch the data from database in this date
@riverpod
Future<List<DailyDataModel>> fetchProductionData(FetchProductionDataRef ref,
    {required todayDate}) async {
  final repository = ref.watch(amberRepositoryProvider);
  return repository.getProductionData(prodDate: todayDate);
}
//provider to add the production data into the database
// final productionRepositoryProvider =
//     Provider.autoDispose((ref) => SupabaseAmbersRepository());
// final productionProvider =
//     FutureProvider.autoDispose.family<void, dynamic>((ref, todayData) {
//   print('inside productionRepository');
//   final repository = ref.watch(productionRepositoryProvider);
//   return repository.addDailyData(todayData: todayData, ambId: 1);
// });

//provider to reset the stepper and go to step 0
final resetStepperProvider = StateProvider.autoDispose<int>((ref) => 0);
