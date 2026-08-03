// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_task_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CreateTask)
final createTaskProvider = CreateTaskProvider._();

final class CreateTaskProvider
    extends $AsyncNotifierProvider<CreateTask, void> {
  CreateTaskProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'createTaskProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$createTaskHash();

  @$internal
  @override
  CreateTask create() => CreateTask();
}

String _$createTaskHash() => r'bdc8726fbfc9787b4f53adca51dfb28ac8715623';

abstract class _$CreateTask extends $AsyncNotifier<void> {
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
