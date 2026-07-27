import 'package:dio/dio.dart';
import 'package:xlerate/core/result.dart';
import 'package:xlerate/data/repositories/programs_repository.dart';
import 'package:xlerate/domain/entities/program.dart';

class MockProgramRepository implements ProgramsRepository {
  final Dio? _dio;

  MockProgramRepository({Dio? dio}) : _dio = dio ?? Dio();

  final _baseURL = "https://6a6182d0da10c59c18098fc4.mockapi.io/api/v1";

  @override
  Future<Result<void>> addProgram({required Program program}) async {
    try {
      await _dio!.post('$_baseURL/programs', data: program);

      return Result.success(null);
    } on DioException catch (e) {
      if (e.response != null && e.response?.data != null) {
        return Result.failed(
          "${e.response?.data['massage'] ?? "Failed to create new program!"}",
        );
      }

      return Result.failed("${e.message}");
    }
  }

  @override
  Future<Result<List<Program>>> getAllPrograms() async {
    try {
      final response = await _dio!.get("$_baseURL/programs");

      final results = List<Map<String, dynamic>>.from(response.data);

      return Result.success(results.map((e) => Program.fromJson(e)).toList());
    } on DioException catch (e) {
      return Result.failed("${e.message}");
    }
  }

  @override
  Future<Result<Program>> getProgramDetails({required String id}) async {
    try {
      final response = await _dio!.get("$_baseURL/programs/:id");

      final result = Map<String, dynamic>.from(response.data);

      return Result.success(Program.fromJson(result));
    } on DioException catch (e) {
      return Result.failed("${e.message}");
    }
  }
}
