// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feedback_answer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FeedbackAnswer _$FeedbackAnswerFromJson(Map<String, dynamic> json) =>
    _FeedbackAnswer(
      questionId: json['questionId'] as String,
      answer: json['answer'],
    );

Map<String, dynamic> _$FeedbackAnswerToJson(_FeedbackAnswer instance) =>
    <String, dynamic>{
      'questionId': instance.questionId,
      'answer': instance.answer,
    };
