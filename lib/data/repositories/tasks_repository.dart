import 'package:xlerate/core/result.dart';
import 'package:xlerate/domain/entities/task.dart';

abstract interface class TasksRepository {
  Future<Result<List<Task>>> getAllTasks({required String userId});
  Future<Result<Task>> getTask({required String taskId});
  Future<Result<void>> addTask({required Task task});
  Future<Result<void>> updateTask({required Task task});
  Future<Result<void>> deleteTask({required String taskId});
}
