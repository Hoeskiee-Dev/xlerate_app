import 'package:xlerate/core/result.dart';
import 'package:xlerate/core/usecase.dart';
import 'package:xlerate/data/repositories/tasks_repository.dart';

class DeleteTask implements UseCase<Result<void>, String> {
  final TasksRepository _tasksRepository;

  DeleteTask({required TasksRepository tasksRepository})
    : _tasksRepository = tasksRepository;

  @override
  Future<Result<void>> call(String params) async {
    var result = await _tasksRepository.deleteTask(taskId: params);

    return switch (result) {
      Success(value: final _) => Result.success(null),
      Failed(:final message) => Result.failed(message),
    };
  }
}
