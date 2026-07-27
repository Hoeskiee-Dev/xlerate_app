import 'package:xlerate/core/result.dart';
import 'package:xlerate/core/usecase.dart';
import 'package:xlerate/data/repositories/programs_repository.dart';
import 'package:xlerate/domain/usecases/create_program/create_program_params.dart';

class CreateProgram implements UseCase<Result<void>, CreateProgramParams> {
  final ProgramsRepository _programsRepository;

  CreateProgram({required ProgramsRepository programsRepository})
    : _programsRepository = programsRepository;

  @override
  Future<Result<void>> call(CreateProgramParams params) async {
    int time = DateTime.now().microsecondsSinceEpoch;

    var result = await _programsRepository.addProgram(
      program: params.program.copyWith(
        id: "mockup-program-id-$time",
      ),
    );

    return switch (result) {
      Success(value: _) => Result.success(null),
      Failed(:final message) => Result.failed(message),
    };
  }
}
