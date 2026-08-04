import 'package:dio/dio.dart';
import 'package:xlerate/core/result.dart';
import 'package:xlerate/data/repositories/feedback_repository.dart';
import 'package:xlerate/data/repositories/programs_repository.dart';
import 'package:xlerate/domain/entities/feedback_submission.dart';

class MockFeedbackRepository implements FeedbackRepository {
  final Dio? _dio;

  MockFeedbackRepository({Dio? dio}) : _dio = dio ?? Dio();

  final _baseURL = "https://6a71ae6af687776c13f08a5a.mockapi.io/api/v1";

  @override
  Future<Result<void>> submitFeedback({
    required FeedbackSubmission submission,
  }) async {
    try {
      final response = await _dio!.post(
        "$_baseURL/feedback_responses",
        data: submission.toJson(),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        return const Result.success(null);
      }

      return const Result.failed("Failed to submit feedback response");
    } on DioException catch (e) {
      return Result.failed(e.message ?? "Network error occurred");
    } catch (e) {
      return Result.failed("An unexpected error occurred: $e");
    }
  }
}
