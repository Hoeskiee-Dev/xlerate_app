import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:xlerate/core/result.dart';
import 'package:xlerate/domain/entities/program.dart';
import 'package:xlerate/domain/usecases/get_program_details/get_program_details.dart';
import 'package:xlerate/presentation/providers/usecases/get_program_details.dart';

part 'program_detail_provider.g.dart';

@riverpod
Future<Program> programDetail(Ref ref, {required String id}) async {
  GetProgramDetails getProgramDetails = ref.read(getProgramDetailsProvider);

  var result = await getProgramDetails(id);

  return switch (result) {
    Success(value: final program) => program,
    Failed(message: final msg) => throw Exception(msg),
  };
}
