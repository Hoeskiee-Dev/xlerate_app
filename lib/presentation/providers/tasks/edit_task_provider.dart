import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:xlerate/core/result.dart';
import 'package:xlerate/domain/entities/task.dart';
import 'package:xlerate/domain/usecases/update_task_details/update_task_details_params.dart';
import 'package:xlerate/presentation/providers/tasks/tasks_list_provider.dart';
import 'package:xlerate/presentation/providers/usecases/update_task_details.dart';

part 'edit_task_provider.g.dart';

@riverpod
class EditTask extends _$EditTask {
  @override
  FutureOr<void> build() {
    return null;
  }

  Future<String?> editTask({
    required UpdateTaskDetailsParams params,
    required Task updatedTask,
  }) async {
    state = const AsyncLoading();

    final updateTaskUsecase = ref.read(updateTaskDetailsProvider);
    final result = await updateTaskUsecase(params);

    if (!ref.mounted) return null;

    switch (result) {
      case Success(value: _):
        state = const AsyncData(null);

        ref.read(tasksListProvider.notifier).updateTaskInState(updatedTask);

        ref.invalidate(tasksListProvider);
        return null;

      case Failed(:final message):
        state = AsyncError(message, StackTrace.current);
        return message;
    }
  }
}
