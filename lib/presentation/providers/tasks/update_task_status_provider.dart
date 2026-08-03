import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:xlerate/core/result.dart';
import 'package:xlerate/domain/usecases/change_task_status/change_task_status_params.dart';
import 'package:xlerate/presentation/providers/tasks/tasks_list_provider.dart';
import 'package:xlerate/presentation/providers/usecases/change_task_status.dart';

part 'update_task_status_provider.g.dart';

@riverpod
class UpdateTaskStatus extends _$UpdateTaskStatus {
  @override
  FutureOr<void> build() {
    return null;
  }

  Future<String?> updateTaskStatus({
    required ChangeTaskStatusParams params,
  }) async {
    state = const AsyncLoading();

    final updateTaskStatusUsecase = ref.read(changeTaskStatusProvider);
    final result = await updateTaskStatusUsecase(params);

    if (!ref.mounted) return null;

    switch (result) {
      case Success(value: _):
        state = const AsyncData(null);
        ref.read(tasksListProvider.notifier).refresh();
        return null;

      case Failed(:final message):
        state = AsyncError(message, StackTrace.current);
        ref.read(tasksListProvider.notifier).refresh();
        return message;
    }
  }
}
