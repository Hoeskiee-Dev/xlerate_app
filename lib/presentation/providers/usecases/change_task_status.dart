import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:xlerate/domain/usecases/change_task_status/change_task_status.dart';
import 'package:xlerate/presentation/providers/repositories/task_repository.dart/task_repository.dart';

part 'change_task_status.g.dart';

@riverpod
ChangeTaskStatus changeTaskStatus(Ref ref) =>
    ChangeTaskStatus(tasksRepository: ref.watch(taskRepositoryProvider));
