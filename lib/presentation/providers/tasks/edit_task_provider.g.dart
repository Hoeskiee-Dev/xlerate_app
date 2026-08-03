// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_task_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(EditTask)
final editTaskProvider = EditTaskProvider._();

final class EditTaskProvider extends $AsyncNotifierProvider<EditTask, void> {
  EditTaskProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'editTaskProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$editTaskHash();

  @$internal
  @override
  EditTask create() => EditTask();
}

String _$editTaskHash() => r'5b46dbc464d589c802034faa2b9877c41086561f';

abstract class _$EditTask extends $AsyncNotifier<void> {
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
