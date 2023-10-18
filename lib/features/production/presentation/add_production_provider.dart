import 'package:flutter/material.dart';
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
// @riverpod
// Future<List<Amber>> fetchAmbers(FetchAmbersRef ref) async {
//   final repository = await ref.watch(amberRepositoryProvider);
//   //final Future<List<Amber>> ambers =
//   return repository.fetchAmbers();
// }

final fetchAmberProvider = FutureProvider((ref) async {
  final repository = await ref.watch(amberRepositoryProvider).fetchAmbers();
  //final Future<List<Amber>> ambers =
  return repository;
});

// class AmberNotifier extends ChangeNotifier {
//   AmberNotifier(this.ambers);
//   Future<List<Amber>> ambers;
//   Future<void> removeAmber(int amberId) async {
//     ambers.then((value) => value.any((element) => element.id != amberId));
//     notifyListeners();
//   }
// }

final ambersProviderNotifier =
    AsyncNotifierProvider.autoDispose<AmbersNotifier, List<Amber>>(() {
  // List<Amber> amlist = [];
  // final AsyncValue<List<Amber>> ambers = ref
  //     .watch(amberRepositoryProvider)
  //     .fetchAmbers() as AsyncValue<List<Amber>>;
  // ambers.whenData((value) => amlist = value);

  // return AmbersNotifier(amlist);
  return AmbersNotifier();
});

//print(amlist);
class AmbersNotifier extends AutoDisposeAsyncNotifier<List<Amber>> {
  //final Ref ref;
  Future<List<Amber>> _fetchAmbers() async {
    final ambers = ref.watch(amberRepositoryProvider).fetchAmbers();
    return ambers;
  }

  @override
  FutureOr<List<Amber>> build() async {
    return _fetchAmbers();
  }

  ///REMOVE the amber that complet the insertion of production data
  void remove(String amberId) {
    state = AsyncValue.data([
      for (final amber in state.value ?? [])
        if (amber.id.toString() != amberId) amber,
    ]);
  }
}

/*class AmberListNotifier extends StateNotifier<List<Amber>> {
  AmberListNotifier(List<Amber> ambers) : super(ambers);

  //final List<Amber> ambers;
  // Future<void> _fetch() async {
  //   state = const AsyncValue.loading();
  //   state = await AsyncValue.guard(() => ref.watch(fetchAmbersProvider));
  // }

  // @override
  // Future<void> build() {}

  Future<void> removeAmber(int amberId) async {
    state = [
      for (final amber in state)
        if (amber.id != amberId) amber,
    ];
  }
}
*/
enum FilterType { completed, none }

// @@riverpod
// class getAmberList extends _$getAmberList {
//   @override
//    build() {
//     final List<Amber> ambers = ref.watch(fetchAmbersProvider);
//     return ambers;
//   }
//   toggle(int amberId){
//      state=[...stata,]
//   }
// }

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
