import 'package:xlerate/core/result.dart';
import 'package:xlerate/core/usecase.dart';
import 'package:xlerate/data/repositories/tasks_repository.dart';
import 'package:xlerate/domain/usecases/update_task_details/update_task_details_params.dart';

class UpdateTaskDetails
    implements UseCase<Result<void>, UpdateTaskDetailsParams> {
  final TasksRepository _tasksRepository;

  UpdateTaskDetails({required TasksRepository tasksRepository})
    : _tasksRepository = tasksRepository;

  @override
  Future<Result<void>> call(UpdateTaskDetailsParams params) async {
    var result = await _tasksRepository.updateTask(task: params.task);

    return switch (result) {
      Success(value: _) => Result.success(null),
      Failed(:final message) => Result.failed(message),
    };
  }
}
