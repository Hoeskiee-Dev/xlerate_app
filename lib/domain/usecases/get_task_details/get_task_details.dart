import 'package:xlerate/core/result.dart';
import 'package:xlerate/core/usecase.dart';
import 'package:xlerate/data/repositories/tasks_repository.dart';
import 'package:xlerate/domain/entities/task.dart';

class GetTaskDetails implements UseCase<Result<Task>, String> {
  final TasksRepository _tasksRepository;

  GetTaskDetails({required TasksRepository tasksRepository})
    : _tasksRepository = tasksRepository;

  @override
  Future<Result<Task>> call(String params) async {
    var result = await _tasksRepository.getTask(taskId: params);

    return switch (result) {
      Success(value: final task) => Result.success(task),
      Failed(:final message) => Result.failed(message),
    };
  }
}
