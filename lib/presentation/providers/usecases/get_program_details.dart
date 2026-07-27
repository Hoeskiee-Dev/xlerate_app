import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:xlerate/domain/usecases/get_program_details/get_program_details.dart';
import 'package:xlerate/presentation/providers/repositories/program_repository/program_repository.dart';

part 'get_program_details.g.dart';

@riverpod
GetProgramDetails getProgramDetails(Ref ref) =>
    GetProgramDetails(programsRepository: ref.watch(programRepositoryProvider));
