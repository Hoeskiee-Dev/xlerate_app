// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_tasks.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(getAllTasks)
final getAllTasksProvider = GetAllTasksProvider._();

final class GetAllTasksProvider
    extends $FunctionalProvider<GetAllTasks, GetAllTasks, GetAllTasks>
    with $Provider<GetAllTasks> {
  GetAllTasksProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getAllTasksProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getAllTasksHash();

  @$internal
  @override
  $ProviderElement<GetAllTasks> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GetAllTasks create(Ref ref) {
    return getAllTasks(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetAllTasks value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetAllTasks>(value),
    );
  }
}

String _$getAllTasksHash() => r'd34f1aa302ea8a2582fb9b3806fdb6e345fed8a6';
