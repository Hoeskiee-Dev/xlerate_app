import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:xlerate/domain/usecases/get_task_details/get_task_details.dart';
import 'package:xlerate/presentation/providers/repositories/task_repository.dart/task_repository.dart';

part 'get_task_details.g.dart';

@riverpod
GetTaskDetails getTaskDetails(Ref ref) =>
    GetTaskDetails(tasksRepository: ref.watch(taskRepositoryProvider));
