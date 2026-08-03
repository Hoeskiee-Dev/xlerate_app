import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:xlerate/domain/usecases/add_task/add_task.dart';
import 'package:xlerate/presentation/providers/repositories/task_repository.dart/task_repository.dart';

part 'add_task.g.dart';

@riverpod
AddTask addTask(Ref ref) =>
    AddTask(tasksRepository: ref.watch(taskRepositoryProvider));
