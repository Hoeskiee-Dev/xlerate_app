import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:xlerate/domain/entities/question_type.dart';

part 'saved_question.freezed.dart';
part 'saved_question.g.dart';

@freezed
abstract class SavedQuestion with _$SavedQuestion {
  @JsonSerializable(explicitToJson: true)
  const factory SavedQuestion({
    required QuestionType type,
    required String title,
    required List<String> options,
    required bool isRequired,
  }) = _SavedQuestion;

  factory SavedQuestion.fromJson(Map<String, dynamic> json) =>
      _$SavedQuestionFromJson(json);
}
