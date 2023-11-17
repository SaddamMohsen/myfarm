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

/// See also [amberReport].
@ProviderFor(amberReport)
const amberReportProvider = AmberReportFamily();

/// See also [amberReport].
class AmberReportFamily extends Family<AsyncValue<DailyReport>> {
  /// See also [amberReport].
  const AmberReportFamily();

  /// See also [amberReport].
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

/// See also [amberReport].
class AmberReportProvider extends AutoDisposeFutureProvider<DailyReport> {
  /// See also [amberReport].
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
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
