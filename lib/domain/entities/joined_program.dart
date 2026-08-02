import 'package:freezed_annotation/freezed_annotation.dart';

part 'joined_program.freezed.dart';
part 'joined_program.g.dart';

@freezed
abstract class JoinedProgram with _$JoinedProgram {
  const factory JoinedProgram({
    required String id,
    required String title,
    required String date,
    @Default('Applied') String status,
  }) = _JoinedProgram;

  factory JoinedProgram.fromJson(Map<String, dynamic> json) =>
      _$JoinedProgramFromJson(json);
}
