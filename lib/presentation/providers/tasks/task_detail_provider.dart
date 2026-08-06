import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:xlerate/core/result.dart';
import 'package:xlerate/domain/entities/task.dart';
import 'package:xlerate/presentation/providers/usecases/get_task_details.dart';

part 'task_detail_provider.g.dart';

@riverpod
class GetTaskInfo extends _$GetTaskInfo {
  @override
  FutureOr<Task?> build(String taskId) async {
    final getTaskDetails = ref.read(getTaskDetailsProvider);

    final result = await getTaskDetails(taskId);

    return switch (result) {
      Success(value: final task) => task,
      Failed(message: final message) => throw Exception(message),
    };
  }
}
