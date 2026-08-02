import 'package:dio/dio.dart';
import 'package:xlerate/core/result.dart';
import 'package:xlerate/data/repositories/tasks_repository.dart';
import 'package:xlerate/domain/entities/task.dart';

class MockTaskRepository implements TasksRepository {
  final Dio? _dio;

  MockTaskRepository({Dio? dio}) : _dio = dio ?? Dio();

  final _baseURL = "https://6a6182d0da10c59c18098fc4.mockapi.io/api/v1";

  @override
  Future<Result<void>> addTask({required Task task}) async {
    try {
      await _dio!.post("$_baseURL/tasks", data: task.toJson());

      return Result.success(null);
    } on DioException catch (e) {
      if (e.response != null && e.response?.data != null) {
        return Result.failed(
          "${e.response?.data['message'] ?? "Failed to create new task!"}",
        );
      }

      return Result.failed("${e.message}");
    } catch (e) {
      return Result.failed("Internal error: $e");
    }
  }

  @override
  Future<Result<void>> deleteTask({required String taskId}) async {
    try {
      await _dio!.delete("$_baseURL/tasks/$taskId");

      return Result.success(null);
    } on DioException catch (e) {
      return Result.failed("${e.message}");
    } catch (e) {
      return Result.failed("Internal error: $e");
    }
  }

  @override
  Future<Result<List<Task>>> getAllTasks({required String userId}) async {
    try {
      final response = await _dio!.get("$_baseURL/tasks?userId=$userId");

      final results = List<Map<String, dynamic>>.from(response.data);

      return Result.success(results.map((e) => Task.fromJson(e)).toList());
    } on DioException catch (e) {
      return Result.failed("${e.message}");
    } catch (e) {
      return Result.failed("Internal error: $e");
    }
  }

  @override
  Future<Result<Task>> getTask({required String taskId}) async {
    try {
      final response = await _dio!.get("$_baseURL/tasks/$taskId");

      final result = Map<String, dynamic>.from(response.data);

      return Result.success(Task.fromJson(result));
    } on DioException catch (e) {
      return Result.failed("${e.message}");
    } catch (e) {
      return Result.failed("Internal error: $e");
    }
  }

  @override
  Future<Result<void>> updateTask({required Task task}) async {
    try {
      await _dio!.put("$_baseURL/tasks/${task.id}", data: task.toJson());

      return Result.success(null);
    } on DioException catch (e) {
      if (e.response != null && e.response?.data != null) {
        return Result.failed(
          "${e.response?.data['message'] ?? "Failed to update task!"}",
        );
      }

      return Result.failed("${e.message}");
    } catch (e) {
      return Result.failed("Internal error: $e");
    }
  }
}
