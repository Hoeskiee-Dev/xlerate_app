import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:xlerate/core/result.dart';
import 'package:xlerate/domain/usecases/edit_program/edit_program_params.dart';
import 'package:xlerate/presentation/providers/usecases/edit_program.dart';

part 'update_program_provider.g.dart';

@Riverpod(keepAlive: true)
class UpdateProgram extends _$UpdateProgram {
  @override
  FutureOr<void> build() {
    return null;
  }

  Future<bool> updateProgram({required EditProgramParams program}) async {
    state = const AsyncLoading();

    final editProgramUsecase = ref.read(editProgramProvider);
    final result = await editProgramUsecase(program);

    if (!ref.mounted) return false;

    switch (result) {
      case Success():
        state = const AsyncData(null);

        return true;

      case Failed(:final message):
        state = AsyncError(message, StackTrace.current);
        return false;
    }
  }
}
