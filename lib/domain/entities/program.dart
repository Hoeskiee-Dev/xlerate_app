import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:xlerate/domain/entities/saved_feedback_form.dart';

part 'program.freezed.dart';
part 'program.g.dart';

@freezed
abstract class Program with _$Program {
  const Program._();

  @JsonSerializable(explicitToJson: true)
  const factory Program({
    String? id,
    required String title,
    required String description,
    required String host,
    String? speaker,
    String? url,
    required String startDate,
    String? endDate,
    required String time,
    required String locationType,
    required String location,
    required String tag,
    required List<String> skills,
    required String eligibility,
    required bool isFree,
    required double fee,
    required bool offersCertificate,
    required bool offersBadge,
    required bool offersMicroScholarships,
    required bool offersLetterOfRecommendation,
    required bool offersPhysicalSwags,
    required bool offersXleratePoints,
    int? xpAmount,
    required String? extraReward,
    required String imageUrl,
    @JsonKey(includeFromJson: false, includeToJson: false) File? imageFile,
    int? totalSeats,
    SavedFeedbackForm? feedbackForm,
    String? registrationDeadLine,
    @JsonKey(defaultValue: []) @Default([]) List<String> joinedUserIds,
  }) = _Program;

  @override
  List<String> get joinedUserIds;

  int get joinedCount => joinedUserIds.length;

  factory Program.fromJson(Map<String, dynamic> json) =>
      _$ProgramFromJson(json);
}
