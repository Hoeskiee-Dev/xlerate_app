// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'program.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Program _$ProgramFromJson(Map<String, dynamic> json) => _Program(
  title: json['title'] as String,
  description: json['description'] as String,
  host: json['host'] as String,
  speaker: json['speaker'] as String?,
  startDate: json['startDate'] as String,
  endDate: json['endDate'] as String?,
  time: json['time'] as String,
  locationType: json['locationType'] as String,
  location: json['location'] as String,
  tag: json['tag'] as String,
  skills: (json['skills'] as List<dynamic>).map((e) => e as String).toList(),
  eligibility: json['eligibility'] as String,
  isFree: json['isFree'] as bool,
  fee: (json['fee'] as num).toDouble(),
  offersCertificate: json['offersCertificate'] as bool,
  offersBadge: json['offersBadge'] as bool,
  offersMicroScholarships: json['offersMicroScholarships'] as bool,
  offersLetterOfRecommendation: json['offersLetterOfRecommendation'] as bool,
  offersPhysicalSwags: json['offersPhysicalSwags'] as bool,
  offersXleratePoints: json['offersXleratePoints'] as bool,
  xpAmount: (json['xpAmount'] as num?)?.toInt(),
  extraReward: json['extraReward'] as String?,
  imageUrl: json['imageUrl'] as String,
  totalSeats: (json['totalSeats'] as num?)?.toInt(),
  joinedCount: (json['joinedCount'] as num).toInt(),
  feedbackForm: json['feedbackForm'] == null
      ? null
      : SavedFeedbackForm.fromJson(
          json['feedbackForm'] as Map<String, dynamic>,
        ),
  registrationDeadLine: json['registrationDeadLine'] as String?,
);

Map<String, dynamic> _$ProgramToJson(_Program instance) => <String, dynamic>{
  'title': instance.title,
  'description': instance.description,
  'host': instance.host,
  'speaker': instance.speaker,
  'startDate': instance.startDate,
  'endDate': instance.endDate,
  'time': instance.time,
  'locationType': instance.locationType,
  'location': instance.location,
  'tag': instance.tag,
  'skills': instance.skills,
  'eligibility': instance.eligibility,
  'isFree': instance.isFree,
  'fee': instance.fee,
  'offersCertificate': instance.offersCertificate,
  'offersBadge': instance.offersBadge,
  'offersMicroScholarships': instance.offersMicroScholarships,
  'offersLetterOfRecommendation': instance.offersLetterOfRecommendation,
  'offersPhysicalSwags': instance.offersPhysicalSwags,
  'offersXleratePoints': instance.offersXleratePoints,
  'xpAmount': instance.xpAmount,
  'extraReward': instance.extraReward,
  'imageUrl': instance.imageUrl,
  'totalSeats': instance.totalSeats,
  'joinedCount': instance.joinedCount,
  'feedbackForm': instance.feedbackForm?.toJson(),
  'registrationDeadLine': instance.registrationDeadLine,
};
