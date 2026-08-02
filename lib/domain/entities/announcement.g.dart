// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'announcement.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Announcement _$AnnouncementFromJson(Map<String, dynamic> json) =>
    _Announcement(
      id: json['id'] as String?,
      title: json['title'] as String,
      description: json['description'] as String,
      date: json['date'] as String,
      type: json['type'] as String,
      imageBase64: json['imageBase64'] as String?,
    );

Map<String, dynamic> _$AnnouncementToJson(_Announcement instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'date': instance.date,
      'type': instance.type,
      'imageBase64': instance.imageBase64,
    };
