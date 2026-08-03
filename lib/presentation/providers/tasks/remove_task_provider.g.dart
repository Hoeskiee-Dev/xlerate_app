// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remove_task_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(RemoveTask)
final removeTaskProvider = RemoveTaskProvider._();

final class RemoveTaskProvider
    extends $AsyncNotifierProvider<RemoveTask, void> {
  RemoveTaskProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'removeTaskProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$removeTaskHash();

  @$internal
  @override
  RemoveTask create() => RemoveTask();
}

String _$removeTaskHash() => r'a17277be159937b9d11e91cb36d82893accbfecd';

abstract class _$RemoveTask extends $AsyncNotifier<void> {
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
