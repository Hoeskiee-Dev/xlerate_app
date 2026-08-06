import 'package:dio/dio.dart';
import 'package:xlerate/core/result.dart';
import 'package:xlerate/data/repositories/user_repository.dart';
import 'package:xlerate/domain/entities/user_model.dart';

class BeUserRepository implements UserRepository {
  final Dio _dio;

  BeUserRepository({Dio? dio}) : _dio = dio ?? Dio();

  final _baseURL = "https://6a69e9dcb2789286ad712ba3.mockapi.io/api/v1";

  @override
  Future<Result<UserModel>> getUserById(String id) async {
    try {
      var response = await _dio.get("$_baseURL/users/$id");

      var result = Map<String, dynamic>.from(response.data);

      return Result.success(UserModel.fromJson(result));
    } on DioException catch (e) {
      if (e.response != null && e.response?.data != null) {
        return Result.failed(
          "${e.response?.data['message'] ?? "Failed to create new program!"}",
        );
      }

      return Result.failed("${e.message}");
    } catch (e) {
      return Result.failed("Internal error : $e");
    }
  }
}
