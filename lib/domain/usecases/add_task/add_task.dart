import 'package:xlerate/core/result.dart';
import 'package:xlerate/core/usecase.dart';
import 'package:xlerate/data/repositories/tasks_repository.dart';
import 'package:xlerate/domain/usecases/add_task/add_task_params.dart';

class AddTask implements UseCase<Result<void>, AddTaskParams> {
  final TasksRepository _tasksRepository;

  AddTask({required TasksRepository tasksRepository})
    : _tasksRepository = tasksRepository;

  @override
  Future<Result<void>> call(AddTaskParams params) async {
    int timeNow = DateTime.now().millisecondsSinceEpoch ~/ 1000;

    var result = await _tasksRepository.addTask(
      task: params.task.copyWith(
        createdAt: timeNow,
      ),
    );

    return switch (result) {
      Success(value: _) => Result.success(null),
      Failed(:final message) => Result.failed(message),
    };
  }
}
