// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'saved_question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SavedQuestion _$SavedQuestionFromJson(Map<String, dynamic> json) =>
    _SavedQuestion(
      type: $enumDecode(_$QuestionTypeEnumMap, json['type']),
      title: json['title'] as String,
      options: (json['options'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      isRequired: json['isRequired'] as bool,
    );

Map<String, dynamic> _$SavedQuestionToJson(_SavedQuestion instance) =>
    <String, dynamic>{
      'type': _$QuestionTypeEnumMap[instance.type]!,
      'title': instance.title,
      'options': instance.options,
      'isRequired': instance.isRequired,
    };

const _$QuestionTypeEnumMap = {
  QuestionType.shortText: 'shortText',
  QuestionType.longText: 'longText',
  QuestionType.multipleChoice: 'multipleChoice',
  QuestionType.checkboxes: 'checkboxes',
  QuestionType.dropdown: 'dropdown',
  QuestionType.starRating: 'starRating',
  QuestionType.fileUpload: 'fileUpload',
  QuestionType.date: 'date',
  QuestionType.emojiRating: 'emojiRating',
  QuestionType.linearScale: 'linearScale',
  QuestionType.yesNo: 'yesNo',
};
