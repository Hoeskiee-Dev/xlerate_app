import 'package:xlerate/core/result.dart';
import 'package:xlerate/domain/entities/feedback_submission.dart';

abstract interface class FeedbackRepository {
  Future<Result<void>> submitFeedback({required FeedbackSubmission submission});
}
