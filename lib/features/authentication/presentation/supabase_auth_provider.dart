import 'package:flutter/widgets.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart' show Supabase, SupabaseClient, User;
import 'package:flutter_riverpod/flutter_riverpod.dart' as riv;
import 'package:myfarm/features/authentication/data/supabase_auth_repository.dart';

part 'supabase_auth_provider.g.dart';

final supabaseClientProvider =
    riv.Provider<SupabaseClient>((ref) => Supabase.instance.client);

@Riverpod(keepAlive: true)
SupabaseAuthRepository supaAuthRep(SupaAuthRepRef ref) =>
    SupabaseAuthRepository(auth: ref.watch(supabaseClientProvider));
// final authRepositoryProvider =
//     riv.Provider((ref) => {SupabaseAuthRepository().signInEmailPassword(email, password)});

@Riverpod(keepAlive: true)
class AuthController extends _$AuthController {
  @override
  FutureOr<void> build() {}

  Future<bool> login(String email, String password) async {
    final repository = ref.read(supaAuthRepProvider);
    state = const AsyncValue.loading();
    //print('state1 :$state');
    state = await AsyncValue.guard(
        () => repository.signInEmailPassword(email, password));
    //print('state2 :$state');
    return state.hasError == true;
  }
  Future<User?> currentUser() async {
    final repository = ref.read(supaAuthRepProvider);
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
            () => Future.value(repository.currentUser));
    // if (repository.currentUser != null)
    //   return left(repository.currentUser);
    // else
    //   return right('no user');
  }
}