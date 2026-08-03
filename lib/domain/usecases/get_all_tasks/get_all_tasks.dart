import 'package:xlerate/core/result.dart';
import 'package:xlerate/core/usecase.dart';
import 'package:xlerate/data/repositories/tasks_repository.dart';
import 'package:xlerate/domain/entities/task.dart';

class GetAllTasks implements UseCase<Result<List<Task>>, String> {
  final TasksRepository _tasksRepository;

  GetAllTasks({required TasksRepository tasksRepository})
    : _tasksRepository = tasksRepository;

  @override
  Future<Result<List<Task>>> call(String params) async {
    final result = await _tasksRepository.getAllTasks(userId: params);

    return switch (result) {
      Success(value: final tasks) => Result.success(tasks),
      Failed(:final message) => Result.failed(message),
    };
  }
}
