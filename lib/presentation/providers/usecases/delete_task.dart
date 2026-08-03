import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:xlerate/domain/usecases/delete_task/delete_task.dart';
import 'package:xlerate/presentation/providers/repositories/task_repository.dart/task_repository.dart';

part 'delete_task.g.dart';

@riverpod
DeleteTask deleteTask(Ref ref) =>
    DeleteTask(tasksRepository: ref.watch(taskRepositoryProvider));
