import 'package:xlerate/core/result.dart';
import 'package:xlerate/core/usecase.dart';
import 'package:xlerate/data/repositories/feedback_repository.dart';

class CheckFeedbackSubmittedParams {
  final String programId;
  final String userId;

  const CheckFeedbackSubmittedParams({
    required this.programId,
    required this.userId,
  });
}

class CheckFeedbackSubmitted
    implements UseCase<Result<bool>, CheckFeedbackSubmittedParams> {
  final FeedbackRepository _feedbackRepository;

  CheckFeedbackSubmitted({required FeedbackRepository feedbackRepository})
    : _feedbackRepository = feedbackRepository;

  @override
  Future<Result<bool>> call(CheckFeedbackSubmittedParams params) async {
    final result = await _feedbackRepository.hasUserSubmittedFeedback(
      programId: params.programId,
      userId: params.userId,
    );

    return switch (result) {
      Success(value: final isSubmitted) => Result.success(isSubmitted),
      Failed(:final message) => Result.failed(message),
    };
  }
}
