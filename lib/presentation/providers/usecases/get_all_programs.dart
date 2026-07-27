import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:xlerate/domain/usecases/get_all_programs/get_all_programs.dart';
import 'package:xlerate/presentation/providers/repositories/program_repository.dart/program_repository.dart';

part 'get_all_programs.g.dart';

@riverpod
GetAllPrograms getAllProgram(Ref ref) =>
    GetAllPrograms(programsRepository: ref.watch(programRepositoryProvider));
