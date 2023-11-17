// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_items_list_data.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getItemsListHash() => r'ac73d14ad1ce09aacb32c54179da0210f73c040b';

///get the items of inventory from the database and expose them into outDialog
///
/// Copied from [getItemsList].
@ProviderFor(getItemsList)
final getItemsListProvider = AutoDisposeFutureProvider<List<Item>>.internal(
  getItemsList,
  name: r'getItemsListProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$getItemsListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetItemsListRef = AutoDisposeFutureProviderRef<List<Item>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
