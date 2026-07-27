import 'package:xlerate/core/result.dart';
import 'package:xlerate/core/usecase.dart';
import 'package:xlerate/data/repositories/programs_repository.dart';
import 'package:xlerate/domain/entities/program.dart';

class GetAllPrograms implements UseCase<Result<List<Program>>, void> {
  final ProgramsRepository _programsRepository;

  GetAllPrograms({required ProgramsRepository programsRepository})
    : _programsRepository = programsRepository;

  @override
  Future<Result<List<Program>>> call(void params) async {
    final result = await _programsRepository.getAllPrograms();

    return switch (result) {
      Success(value: final programs) => Result.success(programs),
      Failed(:final message) => Result.failed(message),
    };
  }
}
