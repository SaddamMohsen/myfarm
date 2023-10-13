// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_production_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$fetchAmbersHash() => r'8cc8253081b97fbce6bcd5ea65b2f31dc4d17a26';

/// See also [fetchAmbers].
@ProviderFor(fetchAmbers)
final fetchAmbersProvider = FutureProvider<List<Amber>>.internal(
  fetchAmbers,
  name: r'fetchAmbersProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$fetchAmbersHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef FetchAmbersRef = FutureProviderRef<List<Amber>>;
String _$fetchProductionDataHash() =>
    r'5b6fbac217710a7fd03c5a049d4e53d942b391b8';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [fetchProductionData].
@ProviderFor(fetchProductionData)
const fetchProductionDataProvider = FetchProductionDataFamily();

/// See also [fetchProductionData].
class FetchProductionDataFamily
    extends Family<AsyncValue<List<DailyDataModel>>> {
  /// See also [fetchProductionData].
  const FetchProductionDataFamily();

  /// See also [fetchProductionData].
  FetchProductionDataProvider call({
    required dynamic todayDate,
  }) {
    return FetchProductionDataProvider(
      todayDate: todayDate,
    );
  }

  @override
  FetchProductionDataProvider getProviderOverride(
    covariant FetchProductionDataProvider provider,
  ) {
    return call(
      todayDate: provider.todayDate,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'fetchProductionDataProvider';
}

/// See also [fetchProductionData].
class FetchProductionDataProvider
    extends AutoDisposeFutureProvider<List<DailyDataModel>> {
  /// See also [fetchProductionData].
  FetchProductionDataProvider({
    required dynamic todayDate,
  }) : this._internal(
          (ref) => fetchProductionData(
            ref as FetchProductionDataRef,
            todayDate: todayDate,
          ),
          from: fetchProductionDataProvider,
          name: r'fetchProductionDataProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$fetchProductionDataHash,
          dependencies: FetchProductionDataFamily._dependencies,
          allTransitiveDependencies:
              FetchProductionDataFamily._allTransitiveDependencies,
          todayDate: todayDate,
        );

  FetchProductionDataProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.todayDate,
  }) : super.internal();

  final dynamic todayDate;

  @override
  Override overrideWith(
    FutureOr<List<DailyDataModel>> Function(FetchProductionDataRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FetchProductionDataProvider._internal(
        (ref) => create(ref as FetchProductionDataRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        todayDate: todayDate,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<DailyDataModel>> createElement() {
    return _FetchProductionDataProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FetchProductionDataProvider && other.todayDate == todayDate;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, todayDate.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin FetchProductionDataRef
    on AutoDisposeFutureProviderRef<List<DailyDataModel>> {
  /// The parameter `todayDate` of this provider.
  dynamic get todayDate;
}

class _FetchProductionDataProviderElement
    extends AutoDisposeFutureProviderElement<List<DailyDataModel>>
    with FetchProductionDataRef {
  _FetchProductionDataProviderElement(super.provider);

  @override
  dynamic get todayDate => (origin as FetchProductionDataProvider).todayDate;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
