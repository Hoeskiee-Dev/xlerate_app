import 'package:xlerate/core/result.dart';
import 'package:xlerate/domain/entities/program.dart';

abstract interface class ProgramsRepository {
  Future<Result<List<Program>>> getAllPrograms();
  Future<Result<Program>> getProgramDetails({required String id});
  Future<Result<void>> addProgram({required Program program});
}
