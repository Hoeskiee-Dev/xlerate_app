import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:xlerate/domain/entities/feedback_answer.dart';

part 'feedback_submission.freezed.dart';
part 'feedback_submission.g.dart';

@freezed
abstract class FeedbackSubmission with _$FeedbackSubmission {
  @JsonSerializable(explicitToJson: true)
  const factory FeedbackSubmission({
    required String formId,
    required String programId,
    required String userId,
    required List<FeedbackAnswer> answers,
    required DateTime submittedAt,
  }) = _FeedbackSubmission;

  factory FeedbackSubmission.fromJson(Map<String, dynamic> json) =>
      _$FeedbackSubmissionFromJson(json);
}
