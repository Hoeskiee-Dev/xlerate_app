import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:xlerate/core/result.dart';
import 'package:xlerate/domain/entities/program.dart';
import 'package:xlerate/domain/usecases/join_program/join_program_params.dart';
import 'package:xlerate/presentation/providers/programs/program_detail_provider.dart';
import 'package:xlerate/presentation/providers/usecases/join_program.dart';

part 'apply_program_provider.g.dart';

@riverpod
class ApplyProgram extends _$ApplyProgram {
  @override
  FutureOr<void> build() {
    return null;
  }

  Future<bool> applyProgram({
    required Program program,
    required String userId,
  }) async {
    state = const AsyncLoading();

    final updatedUserIds = List<String>.from(program.joinedUserIds);
    if (!updatedUserIds.contains(userId)) {
      updatedUserIds.add(userId);
    }

    final params = JoinProgramParams(
      programId: program.id!,
      joinedUserIds: updatedUserIds,
    );

    final joinProgramUsecase = ref.read(joinProgramProvider);
    final result = await joinProgramUsecase(params);

    switch (result) {
      case Success():
        state = const AsyncData(null);
        ref.invalidate(programDetailProvider);
        return true;

      case Failed(:final message):
        state = AsyncError(message, StackTrace.current);
        return false;
    }
  }
}
