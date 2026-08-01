import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:xlerate/data/programs/mock_task_repository.dart';
import 'package:xlerate/data/repositories/tasks_repository.dart';

part "task_repository.g.dart";

@riverpod
TasksRepository taskRepository(Ref ref) => MockTaskRepository();
