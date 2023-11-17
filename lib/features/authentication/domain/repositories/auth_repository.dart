import 'dart:async';

//import 'package:dartz/dartz.dart';
//import 'package:myfarm/features/authentication/domain/user.dart';
//import 'package:myfarm/models/user.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthRepository {
  const AuthRepository(this.authClient);
  final GoTrueClient authClient;
  Session? get currentSession => authClient.currentSession;
  User? get currentUser => authClient.currentUser;
  Future<User?> signInEmailPassword(String email, String password);
  Future<String> signUpEmailAndPassword(String email, String password);

  Future<void> signOut();
}
