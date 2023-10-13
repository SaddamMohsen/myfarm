import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:myfarm/features/authentication/data/auth_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

//import '../models/user.dart';

class SupabaseAuthRepository extends AuthRepository {
  SupabaseAuthRepository({required this.auth}) : super(auth);

  final SupabaseClient auth; //= Supabase.instance.client;

  @override
  User? get currentUser => auth.auth.currentUser;
  @override
  Future<User> signInEmailPassword(String email, String password) async {
    dynamic res = 'no user';
    try {
      return await auth.auth
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
      await auth.auth.signOut();
    } catch (e) {
      print(e.toString());
      rethrow;
    } finally {
      print('done');
      // throw 'done';
      return;
    }
    //throw UnimplementedError();
  }
}
