// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feedback_submission.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FeedbackSubmission _$FeedbackSubmissionFromJson(Map<String, dynamic> json) =>
    _FeedbackSubmission(
      formId: json['formId'] as String,
      programId: json['programId'] as String,
      userId: json['userId'] as String,
      answers: (json['answers'] as List<dynamic>)
          .map((e) => FeedbackAnswer.fromJson(e as Map<String, dynamic>))
          .toList(),
      submittedAt: DateTime.parse(json['submittedAt'] as String),
    );

Map<String, dynamic> _$FeedbackSubmissionToJson(_FeedbackSubmission instance) =>
    <String, dynamic>{
      'formId': instance.formId,
      'programId': instance.programId,
      'userId': instance.userId,
      'answers': instance.answers.map((e) => e.toJson()).toList(),
      'submittedAt': instance.submittedAt.toIso8601String(),
    };
