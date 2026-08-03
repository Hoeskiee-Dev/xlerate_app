import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:xlerate/domain/usecases/get_all_tasks/get_all_tasks.dart';
import 'package:xlerate/presentation/providers/repositories/task_repository.dart/task_repository.dart';

part 'get_all_tasks.g.dart';

@riverpod
GetAllTasks getAllTasks(Ref ref) =>
    GetAllTasks(tasksRepository: ref.watch(taskRepositoryProvider));
