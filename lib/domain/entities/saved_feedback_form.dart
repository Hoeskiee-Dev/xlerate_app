import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:xlerate/domain/entities/saved_question.dart';

part 'saved_feedback_form.freezed.dart';
part 'saved_feedback_form.g.dart';

@freezed
abstract class SavedFeedbackForm with _$SavedFeedbackForm {
  @JsonSerializable(explicitToJson: true)
  const factory SavedFeedbackForm({
    required String id,
    required String title,
    required String description,
    required List<SavedQuestion> questions,
  }) = _SavedFeedbackForm;

  factory SavedFeedbackForm.fromJson(Map<String, dynamic> json) =>
      _$SavedFeedbackFormFromJson(json);
}
