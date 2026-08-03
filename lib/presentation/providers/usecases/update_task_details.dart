import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:xlerate/domain/usecases/update_task_details/update_task_details.dart';
import 'package:xlerate/presentation/providers/repositories/task_repository.dart/task_repository.dart';

part 'update_task_details.g.dart';

@riverpod
UpdateTaskDetails updateTaskDetails(Ref ref) =>
    UpdateTaskDetails(tasksRepository: ref.watch(taskRepositoryProvider));
