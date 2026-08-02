// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Task _$TaskFromJson(Map<String, dynamic> json) => _Task(
  id: json['id'] as String,
  title: json['title'] as String,
  description: json['description'] as String,
  createdAt: (json['createdAt'] as num).toInt(),
  startDate: (json['startDate'] as num).toInt(),
  endDate: (json['endDate'] as num?)?.toInt(),
  isDone: json['isDone'] as bool,
  priority: $enumDecode(_$TaskPriorityEnumMap, json['priority']),
  userId: json['userId'] as String,
);

Map<String, dynamic> _$TaskToJson(_Task instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'description': instance.description,
  'createdAt': instance.createdAt,
  'startDate': instance.startDate,
  'endDate': instance.endDate,
  'isDone': instance.isDone,
  'priority': _$TaskPriorityEnumMap[instance.priority]!,
  'userId': instance.userId,
};

const _$TaskPriorityEnumMap = {
  TaskPriority.low: 'Low',
  TaskPriority.medium: 'Medium',
  TaskPriority.high: 'High',
};
