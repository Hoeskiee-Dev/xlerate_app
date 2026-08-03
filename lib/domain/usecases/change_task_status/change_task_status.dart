import 'package:xlerate/core/result.dart';
import 'package:xlerate/core/usecase.dart';
import 'package:xlerate/data/repositories/tasks_repository.dart';
import 'package:xlerate/domain/usecases/change_task_status/change_task_status_params.dart';

class ChangeTaskStatus
    implements UseCase<Result<void>, ChangeTaskStatusParams> {
  final TasksRepository _tasksRepository;

  ChangeTaskStatus({required TasksRepository tasksRepository})
    : _tasksRepository = tasksRepository;

  @override
  Future<Result<void>> call(ChangeTaskStatusParams params) async {
    var result = await _tasksRepository.changeTaskStatus(
      taskId: params.id,
      isDone: params.isDone,
    );

    return switch (result) {
      Success(value: _) => Result.success(null),
      Failed(:final message) => Result.failed(message),
    };
  }
}
