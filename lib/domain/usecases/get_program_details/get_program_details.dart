import 'package:xlerate/core/result.dart';
import 'package:xlerate/core/usecase.dart';
import 'package:xlerate/data/repositories/programs_repository.dart';
import 'package:xlerate/domain/entities/program.dart';

class GetProgramDetails implements UseCase<Result<Program>, String> {
  final ProgramsRepository _programsRepository;

  GetProgramDetails({required ProgramsRepository programsRepository})
    : _programsRepository = programsRepository;

  @override
  Future<Result<Program>> call(String params) async {
    final result = await _programsRepository.getProgramDetails(id: params);

    return switch (result) {
      Success(value: final program) => Result.success(program),
      Failed(:final message) => Result.failed(message),
    };
  }
}
