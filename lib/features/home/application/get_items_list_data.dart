import 'package:myfarm/config/provider.dart';
import 'package:myfarm/features/authentication/application/supabase_auth_provider.dart';
import 'package:myfarm/features/production/domain/repositories/ambers_repository.dart';
import 'package:myfarm/features/production/infrastructur/repositories/supabase_amber_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_items_list_data.g.dart';

/// initialize the amberRepository
final repositoryProvider = Provider.autoDispose((ref) {
  final user = ref.watch(supaAuthRepProvider.select((v) => v.currentUser));
  if (user == null) throw AssertionError('لم تقم بتسجيل الدخول');

  return SupabaseAmbersRepository(
      supabaseClient: ref.watch(supabaseClientProvider), user: user);
});

//@Riverpod(keepAlive: true)
///get the items of inventory from the database and expose them into outDialog
@riverpod
Future<List<Item>> getItemsList(GetItemsListRef ref) async {
  final repository = ref.watch(repositoryProvider);
  //final Future<List<Item>> items =
  return repository.getItemsName();
}
