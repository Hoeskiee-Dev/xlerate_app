import 'package:xlerate/core/result.dart';
import 'package:xlerate/core/usecase.dart';
import 'package:xlerate/data/repositories/programs_repository.dart';
import 'package:xlerate/domain/usecases/join_program/join_program_params.dart';

class JoinProgram implements UseCase<Result<void>, JoinProgramParams> {
  final ProgramsRepository _programsRepository;

  JoinProgram({required ProgramsRepository programsRepository})
    : _programsRepository = programsRepository;

  @override
  Future<Result<void>> call(JoinProgramParams params) async {
    var result = await _programsRepository.joinProgram(
      joinedUserIds: params.joinedUserIds,
      programId: params.programId,
    );

    return switch (result) {
      Success(value: _) => Result.success(null),
      Failed(:final message) => Result.failed(message),
    };
  }
}
