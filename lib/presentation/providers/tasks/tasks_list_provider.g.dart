// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tasks_list_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(TasksList)
final tasksListProvider = TasksListProvider._();

final class TasksListProvider
    extends $AsyncNotifierProvider<TasksList, List<Task>> {
  TasksListProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'tasksListProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$tasksListHash();

  @$internal
  @override
  TasksList create() => TasksList();
}

String _$tasksListHash() => r'42428e77c50ff220df1168c3f7c19a1a72175542';

abstract class _$TasksList extends $AsyncNotifier<List<Task>> {
  FutureOr<List<Task>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<Task>>, List<Task>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Task>>, List<Task>>,
              AsyncValue<List<Task>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
