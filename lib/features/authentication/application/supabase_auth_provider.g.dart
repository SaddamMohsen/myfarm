// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'supabase_auth_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$supaAuthRepHash() => r'b92be218aa1ee1f76299ed4550914b2f43db755c';

/// See also [supaAuthRep].
@ProviderFor(supaAuthRep)
final supaAuthRepProvider =
    AutoDisposeProvider<SupabaseAuthRepository>.internal(
  supaAuthRep,
  name: r'supaAuthRepProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$supaAuthRepHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef SupaAuthRepRef = AutoDisposeProviderRef<SupabaseAuthRepository>;
String _$authStateChangesHash() => r'522ab4c637516a88053a7a9f58c4acbaee9f0f23';

/// See also [authStateChanges].
@ProviderFor(authStateChanges)
final authStateChangesProvider = AutoDisposeStreamProvider<User?>.internal(
  authStateChanges,
  name: r'authStateChangesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$authStateChangesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AuthStateChangesRef = AutoDisposeStreamProviderRef<User?>;
String _$authControllerHash() => r'69b56c2f2be5ecb4cf43597a264d21f247cccfa1';

/// See also [AuthController].
@ProviderFor(AuthController)
final authControllerProvider =
    AutoDisposeAsyncNotifierProvider<AuthController, void>.internal(
  AuthController.new,
  name: r'authControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$authControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AuthController = AutoDisposeAsyncNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member