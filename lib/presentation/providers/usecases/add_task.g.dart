// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_task.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(addTask)
final addTaskProvider = AddTaskProvider._();

final class AddTaskProvider
    extends $FunctionalProvider<AddTask, AddTask, AddTask>
    with $Provider<AddTask> {
  AddTaskProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'addTaskProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$addTaskHash();

  @$internal
  @override
  $ProviderElement<AddTask> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AddTask create(Ref ref) {
    return addTask(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AddTask value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AddTask>(value),
    );
  }
}

String _$addTaskHash() => r'eda9964d3b992cc766a8a1841becef503e12c243';
