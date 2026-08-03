// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_task_status_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(UpdateTaskStatus)
final updateTaskStatusProvider = UpdateTaskStatusProvider._();

final class UpdateTaskStatusProvider
    extends $AsyncNotifierProvider<UpdateTaskStatus, void> {
  UpdateTaskStatusProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'updateTaskStatusProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$updateTaskStatusHash();

  @$internal
  @override
  UpdateTaskStatus create() => UpdateTaskStatus();
}

String _$updateTaskStatusHash() => r'032f3b4bc69a16737eb7cb28f660c1091eca543a';

abstract class _$UpdateTaskStatus extends $AsyncNotifier<void> {
  FutureOr<void> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<void>, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, void>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
