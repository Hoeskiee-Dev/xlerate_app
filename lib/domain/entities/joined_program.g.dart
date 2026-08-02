// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'joined_program.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_JoinedProgram _$JoinedProgramFromJson(Map<String, dynamic> json) =>
    _JoinedProgram(
      id: json['id'] as String,
      title: json['title'] as String,
      date: json['date'] as String,
      status: json['status'] as String? ?? 'Applied',
    );

Map<String, dynamic> _$JoinedProgramToJson(_JoinedProgram instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'date': instance.date,
      'status': instance.status,
    };
