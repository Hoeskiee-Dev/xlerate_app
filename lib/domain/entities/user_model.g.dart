// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserModel _$UserModelFromJson(Map<String, dynamic> json) => _UserModel(
  id: json['id'] as String? ?? '',
  name: json['name'] as String? ?? '',
  email: json['email'] as String? ?? '',
  role: json['role'] as String? ?? 'Learner',
  dob: json['dob'] as String?,
  avatar: json['avatar'] as String?,
  joinedPrograms: (json['joinedPrograms'] as List<dynamic>?)
      ?.map((e) => JoinedProgram.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$UserModelToJson(_UserModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'role': instance.role,
      'dob': instance.dob,
      'avatar': instance.avatar,
      'joinedPrograms': instance.joinedPrograms,
    };
