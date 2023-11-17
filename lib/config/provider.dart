import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myfarm/features/authentication/application/supabase_auth_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart'
    show Supabase, SupabaseClient;

import 'package:myfarm/config/apikey.dart';

part 'provider.g.dart';

/// Exposes [Supabase] instance

@Riverpod(keepAlive: true)
FutureOr<Supabase> supabase(SupabaseRef ref) async {
  return Supabase.initialize(
    url: supabase_url,
    anonKey: supabase_anonkey,
    debug: true,
  );
}

/// Exposes [SupabaseClient] client
@Riverpod(keepAlive: true)
SupabaseClient supabaseClient(SupabaseClientRef ref) {
  return ref.watch(supabaseProvider).valueOrNull!.client;
}

/// Triggered from bootstrap() to complete futures
Future<void> initializeProviders(ProviderContainer container) async {
  /// Core

  await container.read(supabaseProvider.future);

  /// Auth
  container.read(authControllerProvider);
}
