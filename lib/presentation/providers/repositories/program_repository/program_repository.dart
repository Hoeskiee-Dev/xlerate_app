import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:xlerate/data/programs/mock_program_repository.dart';
import 'package:xlerate/data/repositories/programs_repository.dart';

part "program_repository.g.dart";

@riverpod
ProgramsRepository programRepository(Ref ref) => MockProgramRepository();
