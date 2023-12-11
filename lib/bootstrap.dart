import 'package:intl/date_symbol_data_local.dart';
import 'package:myfarm/config/provider.dart' as providers;
import 'package:myfarm/config/provider_logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Initializes services and controllers before the start of the application

Future<ProviderContainer> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();
  initializeDateFormatting("ar_SA", null);

  final container = ProviderContainer(
    overrides: [], //supabaseProvider.overrideWithValue(Supabase.instance)
    observers: [Logger()],
  );
  await providers.initializeProviders(container);
  return container;
}
