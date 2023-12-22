// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'amber_report_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$amberReportHash() => r'1474a75c471080f8165aa46874608302e6695bb8';

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

///get report for one amber only that speciefied by amberId
///
/// Copied from [amberReport].
@ProviderFor(amberReport)
const amberReportProvider = AmberReportFamily();

///get report for one amber only that speciefied by amberId
///
/// Copied from [amberReport].
class AmberReportFamily extends Family<AsyncValue<DailyReport>> {
  ///get report for one amber only that speciefied by amberId
  ///
  /// Copied from [amberReport].
  const AmberReportFamily();

  ///get report for one amber only that speciefied by amberId
  ///
  /// Copied from [amberReport].
  AmberReportProvider call({
    required int amberId,
    required DateTime repDate,
  }) {
    return AmberReportProvider(
      amberId: amberId,
      repDate: repDate,
    );
  }

  @override
  AmberReportProvider getProviderOverride(
    covariant AmberReportProvider provider,
  ) {
    return call(
      amberId: provider.amberId,
      repDate: provider.repDate,
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
  String? get name => r'amberReportProvider';
}

///get report for one amber only that speciefied by amberId
///
/// Copied from [amberReport].
class AmberReportProvider extends AutoDisposeFutureProvider<DailyReport> {
  ///get report for one amber only that speciefied by amberId
  ///
  /// Copied from [amberReport].
  AmberReportProvider({
    required int amberId,
    required DateTime repDate,
  }) : this._internal(
          (ref) => amberReport(
            ref as AmberReportRef,
            amberId: amberId,
            repDate: repDate,
          ),
          from: amberReportProvider,
          name: r'amberReportProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$amberReportHash,
          dependencies: AmberReportFamily._dependencies,
          allTransitiveDependencies:
              AmberReportFamily._allTransitiveDependencies,
          amberId: amberId,
          repDate: repDate,
        );

  AmberReportProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.amberId,
    required this.repDate,
  }) : super.internal();

  final int amberId;
  final DateTime repDate;

  @override
  Override overrideWith(
    FutureOr<DailyReport> Function(AmberReportRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: AmberReportProvider._internal(
        (ref) => create(ref as AmberReportRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        amberId: amberId,
        repDate: repDate,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<DailyReport> createElement() {
    return _AmberReportProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AmberReportProvider &&
        other.amberId == amberId &&
        other.repDate == repDate;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, amberId.hashCode);
    hash = _SystemHash.combine(hash, repDate.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin AmberReportRef on AutoDisposeFutureProviderRef<DailyReport> {
  /// The parameter `amberId` of this provider.
  int get amberId;

  /// The parameter `repDate` of this provider.
  DateTime get repDate;
}

class _AmberReportProviderElement
    extends AutoDisposeFutureProviderElement<DailyReport> with AmberReportRef {
  _AmberReportProviderElement(super.provider);

  @override
  int get amberId => (origin as AmberReportProvider).amberId;
  @override
  DateTime get repDate => (origin as AmberReportProvider).repDate;
}

String _$farmReportHash() => r'3472da025150ced91abaed477c45952ee491ab6a';

///return daily report of all ambers in the farm only one day
///
/// Copied from [farmReport].
@ProviderFor(farmReport)
const farmReportProvider = FarmReportFamily();

///return daily report of all ambers in the farm only one day
///
/// Copied from [farmReport].
class FarmReportFamily extends Family<AsyncValue<List<DailyReport>>> {
  ///return daily report of all ambers in the farm only one day
  ///
  /// Copied from [farmReport].
  const FarmReportFamily();

  ///return daily report of all ambers in the farm only one day
  ///
  /// Copied from [farmReport].
  FarmReportProvider call({
    required DateTime repDate,
  }) {
    return FarmReportProvider(
      repDate: repDate,
    );
  }

  @override
  FarmReportProvider getProviderOverride(
    covariant FarmReportProvider provider,
  ) {
    return call(
      repDate: provider.repDate,
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
  String? get name => r'farmReportProvider';
}

///return daily report of all ambers in the farm only one day
///
/// Copied from [farmReport].
class FarmReportProvider extends AutoDisposeFutureProvider<List<DailyReport>> {
  ///return daily report of all ambers in the farm only one day
  ///
  /// Copied from [farmReport].
  FarmReportProvider({
    required DateTime repDate,
  }) : this._internal(
          (ref) => farmReport(
            ref as FarmReportRef,
            repDate: repDate,
          ),
          from: farmReportProvider,
          name: r'farmReportProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$farmReportHash,
          dependencies: FarmReportFamily._dependencies,
          allTransitiveDependencies:
              FarmReportFamily._allTransitiveDependencies,
          repDate: repDate,
        );

  FarmReportProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.repDate,
  }) : super.internal();

  final DateTime repDate;

  @override
  Override overrideWith(
    FutureOr<List<DailyReport>> Function(FarmReportRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FarmReportProvider._internal(
        (ref) => create(ref as FarmReportRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        repDate: repDate,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<DailyReport>> createElement() {
    return _FarmReportProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FarmReportProvider && other.repDate == repDate;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, repDate.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin FarmReportRef on AutoDisposeFutureProviderRef<List<DailyReport>> {
  /// The parameter `repDate` of this provider.
  DateTime get repDate;
}

class _FarmReportProviderElement
    extends AutoDisposeFutureProviderElement<List<DailyReport>>
    with FarmReportRef {
  _FarmReportProviderElement(super.provider);

  @override
  DateTime get repDate => (origin as FarmReportProvider).repDate;
}

String _$amberMonthReportHash() => r'cdba7e76725528305f1d5b0f0f20a72174d26283';

///return monthly report of amber day by day
///
///
/// Copied from [amberMonthReport].
@ProviderFor(amberMonthReport)
const amberMonthReportProvider = AmberMonthReportFamily();

///return monthly report of amber day by day
///
///
/// Copied from [amberMonthReport].
class AmberMonthReportFamily
    extends Family<AsyncValue<List<AmberMonthlyReport>>> {
  ///return monthly report of amber day by day
  ///
  ///
  /// Copied from [amberMonthReport].
  const AmberMonthReportFamily();

  ///return monthly report of amber day by day
  ///
  ///
  /// Copied from [amberMonthReport].
  AmberMonthReportProvider call({
    required int amberId,
    required DateTime repDate,
  }) {
    return AmberMonthReportProvider(
      amberId: amberId,
      repDate: repDate,
    );
  }

  @override
  AmberMonthReportProvider getProviderOverride(
    covariant AmberMonthReportProvider provider,
  ) {
    return call(
      amberId: provider.amberId,
      repDate: provider.repDate,
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
  String? get name => r'amberMonthReportProvider';
}

///return monthly report of amber day by day
///
///
/// Copied from [amberMonthReport].
class AmberMonthReportProvider
    extends AutoDisposeFutureProvider<List<AmberMonthlyReport>> {
  ///return monthly report of amber day by day
  ///
  ///
  /// Copied from [amberMonthReport].
  AmberMonthReportProvider({
    required int amberId,
    required DateTime repDate,
  }) : this._internal(
          (ref) => amberMonthReport(
            ref as AmberMonthReportRef,
            amberId: amberId,
            repDate: repDate,
          ),
          from: amberMonthReportProvider,
          name: r'amberMonthReportProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$amberMonthReportHash,
          dependencies: AmberMonthReportFamily._dependencies,
          allTransitiveDependencies:
              AmberMonthReportFamily._allTransitiveDependencies,
          amberId: amberId,
          repDate: repDate,
        );

  AmberMonthReportProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.amberId,
    required this.repDate,
  }) : super.internal();

  final int amberId;
  final DateTime repDate;

  @override
  Override overrideWith(
    FutureOr<List<AmberMonthlyReport>> Function(AmberMonthReportRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: AmberMonthReportProvider._internal(
        (ref) => create(ref as AmberMonthReportRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        amberId: amberId,
        repDate: repDate,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<AmberMonthlyReport>> createElement() {
    return _AmberMonthReportProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AmberMonthReportProvider &&
        other.amberId == amberId &&
        other.repDate == repDate;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, amberId.hashCode);
    hash = _SystemHash.combine(hash, repDate.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin AmberMonthReportRef
    on AutoDisposeFutureProviderRef<List<AmberMonthlyReport>> {
  /// The parameter `amberId` of this provider.
  int get amberId;

  /// The parameter `repDate` of this provider.
  DateTime get repDate;
}

class _AmberMonthReportProviderElement
    extends AutoDisposeFutureProviderElement<List<AmberMonthlyReport>>
    with AmberMonthReportRef {
  _AmberMonthReportProviderElement(super.provider);

  @override
  int get amberId => (origin as AmberMonthReportProvider).amberId;
  @override
  DateTime get repDate => (origin as AmberMonthReportProvider).repDate;
}

String _$outItemsDailyReportHash() =>
    r'057d3841ffd3381dc59c41e9fb2df2272eb47d41';

///Get daily out items by ambers and type
///
/// Copied from [outItemsDailyReport].
@ProviderFor(outItemsDailyReport)
const outItemsDailyReportProvider = OutItemsDailyReportFamily();

///Get daily out items by ambers and type
///
/// Copied from [outItemsDailyReport].
class OutItemsDailyReportFamily
    extends Family<AsyncValue<List<ItemsMovement>>> {
  ///Get daily out items by ambers and type
  ///
  /// Copied from [outItemsDailyReport].
  const OutItemsDailyReportFamily();

  ///Get daily out items by ambers and type
  ///
  /// Copied from [outItemsDailyReport].
  OutItemsDailyReportProvider call({
    required String itemCode,
    required int amberId,
    required DateTime repDate,
  }) {
    return OutItemsDailyReportProvider(
      itemCode: itemCode,
      amberId: amberId,
      repDate: repDate,
    );
  }

  @override
  OutItemsDailyReportProvider getProviderOverride(
    covariant OutItemsDailyReportProvider provider,
  ) {
    return call(
      itemCode: provider.itemCode,
      amberId: provider.amberId,
      repDate: provider.repDate,
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
  String? get name => r'outItemsDailyReportProvider';
}

///Get daily out items by ambers and type
///
/// Copied from [outItemsDailyReport].
class OutItemsDailyReportProvider
    extends AutoDisposeFutureProvider<List<ItemsMovement>> {
  ///Get daily out items by ambers and type
  ///
  /// Copied from [outItemsDailyReport].
  OutItemsDailyReportProvider({
    required String itemCode,
    required int amberId,
    required DateTime repDate,
  }) : this._internal(
          (ref) => outItemsDailyReport(
            ref as OutItemsDailyReportRef,
            itemCode: itemCode,
            amberId: amberId,
            repDate: repDate,
          ),
          from: outItemsDailyReportProvider,
          name: r'outItemsDailyReportProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$outItemsDailyReportHash,
          dependencies: OutItemsDailyReportFamily._dependencies,
          allTransitiveDependencies:
              OutItemsDailyReportFamily._allTransitiveDependencies,
          itemCode: itemCode,
          amberId: amberId,
          repDate: repDate,
        );

  OutItemsDailyReportProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.itemCode,
    required this.amberId,
    required this.repDate,
  }) : super.internal();

  final String itemCode;
  final int amberId;
  final DateTime repDate;

  @override
  Override overrideWith(
    FutureOr<List<ItemsMovement>> Function(OutItemsDailyReportRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: OutItemsDailyReportProvider._internal(
        (ref) => create(ref as OutItemsDailyReportRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        itemCode: itemCode,
        amberId: amberId,
        repDate: repDate,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<ItemsMovement>> createElement() {
    return _OutItemsDailyReportProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is OutItemsDailyReportProvider &&
        other.itemCode == itemCode &&
        other.amberId == amberId &&
        other.repDate == repDate;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, itemCode.hashCode);
    hash = _SystemHash.combine(hash, amberId.hashCode);
    hash = _SystemHash.combine(hash, repDate.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin OutItemsDailyReportRef
    on AutoDisposeFutureProviderRef<List<ItemsMovement>> {
  /// The parameter `itemCode` of this provider.
  String get itemCode;

  /// The parameter `amberId` of this provider.
  int get amberId;

  /// The parameter `repDate` of this provider.
  DateTime get repDate;
}

class _OutItemsDailyReportProviderElement
    extends AutoDisposeFutureProviderElement<List<ItemsMovement>>
    with OutItemsDailyReportRef {
  _OutItemsDailyReportProviderElement(super.provider);

  @override
  String get itemCode => (origin as OutItemsDailyReportProvider).itemCode;
  @override
  int get amberId => (origin as OutItemsDailyReportProvider).amberId;
  @override
  DateTime get repDate => (origin as OutItemsDailyReportProvider).repDate;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
