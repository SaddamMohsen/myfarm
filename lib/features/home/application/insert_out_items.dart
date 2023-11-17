import 'package:dartz/dartz.dart';
import 'package:dartz/dartz_unsafe.dart';
import 'package:myfarm/config/provider.dart';
import 'package:myfarm/features/authentication/application/supabase_auth_provider.dart';
import 'package:myfarm/features/common/domain/failure.dart';
import 'package:myfarm/features/production/domain/entities/items_movement.dart';
import 'package:myfarm/features/production/infrastructur/repositories/supabase_amber_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'insert_out_items.g.dart';

/// initialize the amberRepository
final repositoryProvider = Provider.autoDispose((ref) {
  final user = ref.watch(supaAuthRepProvider.select((v) => v.currentUser));
  if (user == null) throw AssertionError('لم تقم بتسجيل الدخول');

  return SupabaseAmbersRepository(
      supabaseClient: ref.watch(supabaseClientProvider), user: user);
});

@riverpod
class InsertOutItemsController extends _$InsertOutItemsController {
  @override
  FutureOr<void> build() {
    // return null;
  }

  ///
  Future<bool> handle(List<ItemsMovement> outData) async {
    state = const AsyncValue.loading();
    // final res =
    //     await ref.read(repositoryProvider).insertOutItems(itemsData: outData);
    final repository = ref.read(repositoryProvider);
    try {
      state = await AsyncValue.guard(
          () => repository.insertOutItems(itemsData: outData));
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }

    // state = res.fold((l) => AsyncValue.error(l.error, StackTrace.current),
    //     AsyncValue<ItemsMovement>.data);

    return state.hasError == true;
  }
}

// @riverpod
// Future<Either<Failure, ItemsMovement>> insertOutItems(InsertOutItemsRef ref,
//     {required List<ItemsMovement> outData}) {
//   final repository = ref.watch(repositoryProvider);
//   print('in insert out provider');
//   return repository.insertOutItems(itemsData: outData);
// }
