// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'change_task_status.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(changeTaskStatus)
final changeTaskStatusProvider = ChangeTaskStatusProvider._();

final class ChangeTaskStatusProvider
    extends
        $FunctionalProvider<
          ChangeTaskStatus,
          ChangeTaskStatus,
          ChangeTaskStatus
        >
    with $Provider<ChangeTaskStatus> {
  ChangeTaskStatusProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'changeTaskStatusProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$changeTaskStatusHash();

  @$internal
  @override
  $ProviderElement<ChangeTaskStatus> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ChangeTaskStatus create(Ref ref) {
    return changeTaskStatus(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ChangeTaskStatus value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ChangeTaskStatus>(value),
    );
  }
}

String _$changeTaskStatusHash() => r'4f73e94d0aa0ca76c6d9686e42e586ac6a3c0823';
