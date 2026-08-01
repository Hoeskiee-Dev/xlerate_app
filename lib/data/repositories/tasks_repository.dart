import 'package:xlerate/core/result.dart';
import 'package:xlerate/domain/entities/task.dart';

abstract interface class TasksRepository {
  Future<Result<List<Task>>> getAllTasks({required String userId});
  Future<Result<Task>> getTask({required String taskId});
  Future<Result<Task>> addTask({required Task task});
  Future<Result<Task>> updateTask({required Task task});
  Future<Result<void>> deleteTask({required String taskId});
}
