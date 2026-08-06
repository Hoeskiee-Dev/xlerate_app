import 'package:xlerate/core/result.dart';
import 'package:xlerate/core/usecase.dart';
import 'package:xlerate/data/repositories/feedback_repository.dart';
import 'package:xlerate/domain/entities/feedback_submission.dart';

class SubmitFeedback implements UseCase<Result<void>, FeedbackSubmission> {
  final FeedbackRepository _feedbackRepository;

  SubmitFeedback({required FeedbackRepository feedbackRepository})
    : _feedbackRepository = feedbackRepository;

  @override
  Future<Result<void>> call(FeedbackSubmission params) async {
    var result = await _feedbackRepository.submitFeedback(submission: params);

    return switch (result) {
      Success(value: _) => Result.success(null),
      Failed(:final message) => Result.failed(message),
    };
  }
}
