// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'saved_feedback_form.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SavedFeedbackForm _$SavedFeedbackFormFromJson(Map<String, dynamic> json) =>
    _SavedFeedbackForm(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      questions: (json['questions'] as List<dynamic>)
          .map((e) => SavedQuestion.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SavedFeedbackFormToJson(_SavedFeedbackForm instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'questions': instance.questions.map((e) => e.toJson()).toList(),
    };
