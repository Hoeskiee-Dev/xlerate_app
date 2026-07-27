import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:xlerate/core/result.dart';
import 'package:xlerate/domain/usecases/create_program/create_program_params.dart';
import 'package:xlerate/presentation/providers/programs/programs_list_provider.dart';
import 'package:xlerate/presentation/providers/usecases/create_program.dart';

part 'add_program_provider.g.dart';

@riverpod
class AddProgram extends _$AddProgram {
  @override
  FutureOr<void> build() {
    return null;
  }

  Future<String?> submitProgram({required CreateProgramParams params}) async {
    state = const AsyncLoading();

    final createProgramUsecase = ref.read(createProgramProvider);
    final result = await createProgramUsecase(params);

    if (!ref.mounted) return null;

    switch (result) {
      case Success(value: _):
        state = const AsyncData(null);
        ref.invalidate(programsListProvider);
        return null;

      case Failed(:final message):
        state = AsyncError(message, StackTrace.current);
        return message;
    }
  }
}
