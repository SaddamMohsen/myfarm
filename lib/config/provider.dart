import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myfarm/features/authentication/application/supabase_auth_provider.dart';
import 'package:myfarm/features/common/application/network_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart'
    show Supabase, SupabaseClient;
import 'package:myfarm/config/apikey.dart';

part 'provider.g.dart';

// /// check internet connectivity
// ///
// @riverpod
// FutureOr<ConnectivityResult> checkInternet(CheckInternetRef ref) async {
//   late ConnectivityResult result;
//   try {
//     result = await Connectivity().checkConnectivity();
//     print('inside check internet provider $result');
//     // getConnectionType(result);
//     // print(result);
//     return result;
//   } on PlatformException catch (e) {
//     developer.log('Couldn\'t check connectivity status', error: e);
//     throw UnimplementedError('Error in check connectivity');
//   }
// }

// final connectivityChangesProvider =
//     Provider.autoDispose<StreamSubscription<ConnectivityResult>>((ref) {
//   //get connectivity result
//   print('get connectivity result');
//   developer.log('get connectivity result');
//   return Connectivity().onConnectivityChanged.listen((event) {
//     ref.watch(checkInternetProvider.future);
//   });
// });

/// Exposes [Supabase] instance

@Riverpod(keepAlive: true)
FutureOr<Supabase> supabase(SupabaseRef ref) async {
  // if (ref.read(networkAwareProvider) == NetworkStatus.On) {
  return Supabase.initialize(
    url: supabase_url,
    anonKey: supabase_anonkey,
    debug: true,
  );
  // } else
  //   throw UnimplementedError('no internet connection');
}

/// Exposes [SupabaseClient] client
@Riverpod(keepAlive: true)
SupabaseClient supabaseClient(SupabaseClientRef ref) {
  return ref.watch(supabaseProvider).valueOrNull!.client;
}

/// Triggered from bootstrap() to complete futures
Future<void> initializeProviders(ProviderContainer container) async {
  ///
  ///

  print('inside initialized provider');
  container.read(networkAwareProvider.notifier);

  /// Core

  await container.read(supabaseProvider.future);

  /// Auth
  container.read(authControllerProvider);
}
