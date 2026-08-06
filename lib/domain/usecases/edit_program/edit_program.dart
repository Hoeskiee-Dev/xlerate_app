import 'package:xlerate/core/result.dart';
import 'package:xlerate/core/usecase.dart';
import 'package:xlerate/data/repositories/programs_repository.dart';
import 'package:xlerate/domain/usecases/edit_program/edit_program_params.dart';

class EditProgram implements UseCase<Result<void>, EditProgramParams> {
  final ProgramsRepository _programsRepository;

  EditProgram({required ProgramsRepository programsRepository})
    : _programsRepository = programsRepository;

  @override
  Future<Result<void>> call(EditProgramParams params) async {
    var result = await _programsRepository.editProgram(program: params.program);

    return switch (result) {
      Success(value: _) => Result.success(null),
      Failed(:final message) => Result.failed(message),
    };
  }
}
