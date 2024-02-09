import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myfarm/features/common/application/network_provider.dart';
import 'package:myfarm/features/production/domain/repositories/ambers_repository.dart';
import 'package:myfarm/features/production/infrastructur/repositories/supabase_amber_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../authentication/application/supabase_auth_provider.dart';
import 'package:myfarm/config/provider.dart';

//part 'add_production_provider.g.dart';

//initialize the amberRepository provider
//@Riverpod(keepAlive:true)
final amberRepositoryProvider = Provider.autoDispose((ref) {
  final internetConnection = ref.watch(networkAwareProvider);
  //print('check net in amber repo ${internetConnection}');
  if (internetConnection != NetworkStatus.On) {
    throw AssertionError('لا يوجد اتصال انترنت');
  }
  final user = ref.watch(supaAuthRepProvider.select((v) => v.currentUser));
  if (user == null) throw AssertionError('لم تقم بتسجيل الدخول');

  return SupabaseAmbersRepository(
      supabaseClient: ref.watch(supabaseClientProvider), user: user);
});

//provider to get the list of ambers in the farm
final fetchAmberProvider = FutureProvider.autoDispose((ref) async {
  final repository = await ref.watch(amberRepositoryProvider).fetchAmbers();
  return repository;
});

///provider that keep the state of uncompleted ambers
final ambersProviderNotifier =
    AsyncNotifierProvider.autoDispose<AmbersNotifier, List<Amber>>(() {
  return AmbersNotifier();
});

///Notifier to remove  amber  from the list of ambers in the dropdown
///after finish the data insertion to make the insertion easy to user
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

//provider to reset the stepper and go to step 0
final resetStepperProvider = StateProvider.autoDispose<int>((ref) => 0);
