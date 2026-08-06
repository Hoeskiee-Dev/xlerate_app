import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:xlerate/domain/usecases/edit_program/edit_program.dart';
import 'package:xlerate/presentation/providers/repositories/program_repository/program_repository.dart';

part 'edit_program.g.dart';

@riverpod
EditProgram editProgram(Ref ref) =>
    EditProgram(programsRepository: ref.watch(programRepositoryProvider));
