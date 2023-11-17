import 'package:myfarm/config/provider.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart' show User;
import 'package:flutter_riverpod/flutter_riverpod.dart' as riv;
import 'package:myfarm/features/authentication/infrastructure/repositories/supabase_auth_repository.dart';

part 'supabase_auth_provider.g.dart';

// final supabaseClientProvider =
//     Provider<SupabaseClient>((ref) => Supabase.instance.client);

@riverpod
SupabaseAuthRepository supaAuthRep(SupaAuthRepRef ref) {
  final authClient = ref.watch(supabaseClientProvider).auth;
  return SupabaseAuthRepository(authClient: authClient);
}

@riverpod
Stream<User?> authStateChanges(AuthStateChangesRef ref) async* {
  final authStream = ref.watch(supaAuthRepProvider).authState;
  await for (final authState in authStream) {
    yield authState.session?.user;
  }
}
// final authRepositoryProvider =
//     riv.Provider((ref) => {SupabaseAuthRepository().signInEmailPassword(email, password)});

//@Riverpod(keepAlive: true)
@riverpod
class AuthController extends _$AuthController {
  @override
  FutureOr<void> build() {}
  // FutureOr<User?> build() async {
  //   final repository = ref.watch(supaAuthRepProvider).currentUser;
  //   //final res = await repository.restoreSession();
  //   final userEntity = repository; //..fold((l) => null, (r) => r);
  //   //_updateAuthState(userEntity);
  //   if (userEntity?.id == null) print('no user');

  //   /// try to create session from deep link
  //   //await _handleInitialDeepLink();
  //   return userEntity;
  // }

  /// listen to auth changes
  //   repository.authStateChang((user) {
  //     state = AsyncData(user);
  //     _updateAuthState(userEntity);
  //   });
  //   return userEntity;
  //   // TODO(vh): how to cancel subscription override dispose
  // }

  // void _updateAuthState(User? userEntity) {
  //   authState.value = userEntity != null;
  // }

  Future<bool> login(String email, String password) async {
    final repository = ref.read(supaAuthRepProvider);
    state = const AsyncValue.loading();
    //print('state1 :$state');
    state = await AsyncValue.guard(
        () => repository.signInEmailPassword(email, password));
    //print('state2 :$state');
    return state.hasError == true;
  }

  ///
  ///get the curernt session
  Future<bool> currentSession() async {
    final repository = ref.read(supaAuthRepProvider).currentSession;
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => Future(() => repository?.accessToken));
    //return state.asData?.value ;
    return state.hasError == false;
  }

  ///get the current logged in user
  Future<User?> currentUser() async {
    final repository = ref.read(supaAuthRepProvider);
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => Future.value(repository.currentUser));
    return null;
    // if (repository.currentUser != null)
    //   return left(repository.currentUser);
    // else
    //   return right('no user');
  }

  Future<void> signOut() async {
    final repository = ref.read(supaAuthRepProvider).signOut();
    state = const AsyncValue.loading();
    // state = await AsyncValue.guard(() =>);
  }
}
