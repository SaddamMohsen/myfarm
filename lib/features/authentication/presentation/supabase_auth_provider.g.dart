// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'supabase_auth_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$supaAuthRepHash() => r'eaf4a288111ecaaff8ce01f46808beaefb97b508';

/// See also [supaAuthRep].
@ProviderFor(supaAuthRep)
final supaAuthRepProvider = Provider<SupabaseAuthRepository>.internal(
  supaAuthRep,
  name: r'supaAuthRepProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$supaAuthRepHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef SupaAuthRepRef = ProviderRef<SupabaseAuthRepository>;
String _$authControllerHash() => r'ae886dc5acd3c7eb3930ba2feded1015f7cfff37';

/// See also [AuthController].
@ProviderFor(AuthController)
final authControllerProvider =
    AsyncNotifierProvider<AuthController, void>.internal(
  AuthController.new,
  name: r'authControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$authControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AuthController = AsyncNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
