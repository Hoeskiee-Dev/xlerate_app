import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:xlerate/core/result.dart';
import 'package:xlerate/presentation/providers/tasks/tasks_list_provider.dart';
import 'package:xlerate/presentation/providers/usecases/delete_task.dart';

part 'remove_task_provider.g.dart';

@riverpod
class RemoveTask extends _$RemoveTask {
  @override
  FutureOr<void> build() {
    return null;
  }

  Future<String?> removeTask({required String params}) async {
    state = const AsyncLoading();

    final deleteTaskUsecase = ref.read(deleteTaskProvider);
    final result = await deleteTaskUsecase(params);

    if (!ref.mounted) return null;

    switch (result) {
      case Success(value: _):
        state = const AsyncData(null);
        ref.read(tasksListProvider.notifier).removeTaskFromState(params);
        return null;

      case Failed(:final message):
        state = AsyncError(message, StackTrace.current);
        ref.read(tasksListProvider.notifier).refresh();
        return message;
    }
  }
}
