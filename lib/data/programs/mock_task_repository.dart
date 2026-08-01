import 'package:dio/dio.dart';
import 'package:xlerate/core/result.dart';
import 'package:xlerate/data/repositories/tasks_repository.dart';
import 'package:xlerate/domain/entities/task.dart';

class MockTaskRepository implements TasksRepository {
  final Dio? _dio;

  MockTaskRepository({Dio? dio}) : _dio = dio ?? Dio();

  final _baseURL = "https://6a6182d0da10c59c18098fc4.mockapi.io/api/v1";

  @override
  Future<Result<Task>> addTask({required Task task}) async {
    // TODO: implement addTask
    throw UnimplementedError();
  }

  @override
  Future<Result<void>> deleteTask({required String taskId}) async {
    // TODO: implement deleteTask
    throw UnimplementedError();
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
    // TODO: implement getTask
    throw UnimplementedError();
  }

  @override
  Future<Result<Task>> updateTask({required Task task}) async {
    // TODO: implement updateTask
    throw UnimplementedError();
  }
}
