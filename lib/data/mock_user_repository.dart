import 'package:dio/dio.dart';
import 'package:xlerate/core/result.dart';
import 'package:xlerate/domain/entities/user_model.dart';

/// Repository responsible for handling user authentication and cloud data
/// synchronization using a MockAPI backend and Dio for HTTP networking.
class MockUserRepository {
  final Dio _dio;

  // Base URL for the MockAPI cloud database service
  final String _baseURL = "https://6a69e9dcb2789286ad712ba3.mockapi.io";

  // Dependency injection constructor allowing a custom Dio instance for testing
  MockUserRepository({Dio? dio}) : _dio = dio ?? Dio();

  /// Registers a new user account by sending user details and a password to the cloud.
  Future<Result<UserModel>> registerUser({
    required UserModel user,
    required String password,
  }) async {
    try {
      // 1. Convert user entity into a mutable map JSON structure
      final Map<String, dynamic> userData = user.toJson();

      // 2. Remove the empty ID field so MockAPI auto-generates a unique database ID
      userData.remove('id');

      // 3. Attach the plain text password for mock backend authentication
      userData['password'] = password;

      // Debug logs for monitoring payload dispatch
      print("--- ATTEMPTING TO REGISTER AT: $_baseURL/users ---");
      print("Payload being sent: $userData");

      // 4. Perform POST request with explicit JSON headers
      final response = await _dio.post(
        '$_baseURL/users',
        data: userData,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      // Return successful result wrapped with the newly created UserModel
      return Result.success(UserModel.fromJson(response.data));
    } on DioException catch (e) {
      // Handle Dio-specific errors and extract server validation messages safely
      if (e.response != null && e.response?.data is Map) {
        return Result.failed(
          "${e.response?.data['message'] ?? "Failed to create user!"}",
        );
      }
      return Result.failed("Server error: ${e.response?.data ?? e.message}");
    } catch (e) {
      // Handle generic runtime errors
      return Result.failed("Internal error : $e");
    }
  }

  /// Authenticates an existing user by querying the database via email and validating the password.
  Future<Result<UserModel>> login({
    required String email,
    required String password,
  }) async {
    try {
      // Query MockAPI filtering records by email parameter
      final response = await _dio.get("$_baseURL/users?email=$email");

      // 1. Safety check: Handle cases where the backend returns a string instead of a list
      if (response.data is String) {
        return const Result.failed("No account found. Please register first!");
      }

      final results = List<Map<String, dynamic>>.from(response.data);

      // Verify if any account matched the email query
      if (results.isEmpty) {
        return const Result.failed("No account found. Please register first!");
      }

      final userRecord = results.first;

      // Match password credentials
      if (userRecord['password'] == password) {
        return Result.success(UserModel.fromJson(userRecord));
      } else {
        return const Result.failed("Incorrect password.");
      }
    } on DioException catch (e) {
      // 2. Handle HTTP 404 Not Found gracefully with a custom message
      if (e.response?.statusCode == 404) {
        return const Result.failed("No account found. Please register first!");
      }
      return Result.failed("Network error: ${e.message}");
    } catch (e) {
      return const Result.failed("System error: Please try again.");
    }
  }

  /// Sends updated user attributes (like name or email) to sync changes to the cloud.
  Future<Result<UserModel>> updateProfile(UserModel user) async {
    try {
      // Perform PUT request targeting the specific user record ID
      final response = await _dio.put(
        '$_baseURL/users/${user.id}',
        data: user.toJson(),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );
      return Result.success(UserModel.fromJson(response.data));
    } on DioException catch (e) {
      return Result.failed("Network error: ${e.message}");
    } catch (e) {
      return Result.failed("Internal error : $e");
    }
  }
}
