import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:xlerate/core/result.dart';
import 'package:xlerate/domain/usecases/add_task/add_task_params.dart';
import 'package:xlerate/presentation/providers/tasks/tasks_list_provider.dart';
import 'package:xlerate/presentation/providers/usecases/add_task.dart';

part 'add_task_provider.g.dart';

@riverpod
class CreateTask extends _$CreateTask {
  @override
  FutureOr<void> build() {
    return null;
  }

  Future<String?> submitTask({required AddTaskParams params}) async {
    state = const AsyncLoading();

    final createTaskUsercase = ref.read(addTaskProvider);
    final result = await createTaskUsercase(params);

    if (!ref.mounted) return null;

    switch (result) {
      case Success(value: _):
        state = const AsyncData(null);
        ref.invalidate(tasksListProvider);
        return null;

      case Failed(:final message):
        state = AsyncError(message, StackTrace.current);
        return message;
    }
  }
}
