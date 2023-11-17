import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:myfarm/features/authentication/domain/repositories/auth_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

//import '../models/user.dart';

class SupabaseAuthRepository extends AuthRepository {
  SupabaseAuthRepository({required this.authClient}) : super(authClient);

  /// Exposes Supabase auth client to allow Auth Controller to subscribe to auth changes
  final GoTrueClient authClient;
  @override
  User? get currentUser => authClient.currentUser;

  @override
  Session? get currentSession => authClient.currentSession;
  //
  Stream<AuthState> get authState => authClient.onAuthStateChange;

  Future<User?> restoreSession() async {
    final response =
        await authClient.recoverSession(currentSession!.accessToken.toString());
    final user = response.user;
    print(user);
    return user;
  }

  @override
  Future<User> signInEmailPassword(String email, String password) async {
    dynamic res = 'no user';
    try {
      return await authClient
          .signInWithPassword(email: email, password: password)
          .then((value) => value.user ?? res);
    } on AuthException catch (e) {
      if (kDebugMode) {
        print(' postEx1 : ${e.message}');
      }
      rethrow;
    } catch (e) {
      if (kDebugMode) {
        print('error2 ${e.toString()}');
      }
      rethrow;
    }
  }

  @override
  Future<String> signUpEmailAndPassword(String email, String password) {
    // TODO: implement signUpEmailAndPassword
    throw UnimplementedError();
  }

  @override
  Future<void> signOut() async {
    try {
      await authClient.signOut(scope: SignOutScope.global);
    } catch (e) {
      throw e.toString();
    }
    //throw UnimplementedError();
  }
}
