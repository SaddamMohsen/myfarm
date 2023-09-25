import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:myfarm/features/authentication/data/auth_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:dartz/dartz.dart';

//import '../models/user.dart';

class SupabaseAuthRepository extends AuthRepository {
  SupabaseAuthRepository({required this.auth}):super(auth);

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
      //.whenComplete(
      //  () => print('fetching user'),
      //);
      //.then((value) => res = value.user);

      //final Future<User?> user = response.then((value) => value.user);
      //print('response ');
      //print(response);
      //print('user');

      //return Future.value(user as FutureOr<User>?);
      // response.whenComplete((res) =>
      // return right(AppUser(response['uuid'],response['name'],response['email'],int.parse(response['meta-data']));
      // ));
    } on AuthException catch (e) {
      print(' postEx1 : ${e.message}');
      throw e;
    } catch (e) {
      print('error2 ${e.toString()}');
      throw e;
    }

    // TODO: implement signInEmailAndPassword
    //throw UnimplementedError();
  }

  @override
  Future<String> signUpEmailAndPassword(String email, String password) {
    // TODO: implement signUpEmailAndPassword
    throw UnimplementedError();
  }

  @override
  Future<void> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }
}
