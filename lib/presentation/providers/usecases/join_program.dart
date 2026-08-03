import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:xlerate/domain/usecases/join_program/join_program.dart';
import 'package:xlerate/presentation/providers/repositories/program_repository/program_repository.dart';

part 'join_program.g.dart';

@riverpod
JoinProgram joinProgram(Ref ref) =>
    JoinProgram(programsRepository: ref.watch(programRepositoryProvider));
