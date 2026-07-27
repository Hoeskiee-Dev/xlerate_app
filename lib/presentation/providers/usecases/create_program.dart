import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:xlerate/domain/usecases/create_program/create_program.dart';
import 'package:xlerate/presentation/providers/repositories/program_repository/program_repository.dart';

part 'create_program.g.dart';

@riverpod
CreateProgram createProgram(Ref ref) =>
    CreateProgram(programsRepository: ref.watch(programRepositoryProvider));
