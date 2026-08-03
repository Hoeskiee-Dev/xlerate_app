// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_task.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(deleteTask)
final deleteTaskProvider = DeleteTaskProvider._();

final class DeleteTaskProvider
    extends $FunctionalProvider<DeleteTask, DeleteTask, DeleteTask>
    with $Provider<DeleteTask> {
  DeleteTaskProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'deleteTaskProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$deleteTaskHash();

  @$internal
  @override
  $ProviderElement<DeleteTask> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  DeleteTask create(Ref ref) {
    return deleteTask(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DeleteTask value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DeleteTask>(value),
    );
  }
}

String _$deleteTaskHash() => r'5f4db5c933bf632e869c7a480b734e8bd14f9e17';
