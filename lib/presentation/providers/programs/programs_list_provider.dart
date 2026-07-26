import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:xlerate/core/result.dart';
import 'package:xlerate/domain/entities/program.dart';
import 'package:xlerate/domain/usecases/get_all_programs/get_all_programs.dart';
import 'package:xlerate/presentation/providers/usecases/get_all_programs.dart';

part 'programs_list_provider.g.dart';

@Riverpod(keepAlive: true)
class ProgramsList extends _$ProgramsList {
  @override
  FutureOr<List<Program>> build() async {
    return _getProgramsList();
  }

  Future<List<Program>> _getProgramsList() async {
    GetAllPrograms getAllPrograms = ref.read(getAllProgramProvider);

    var result = await getAllPrograms(null);

    return switch (result) {
      Success(value: final programs) => programs,
      Failed(message: final msg) => () {
        print("Error on get all programs : $msg");
        throw Exception(msg);
      }(),
    };
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _getProgramsList());
  }
}
