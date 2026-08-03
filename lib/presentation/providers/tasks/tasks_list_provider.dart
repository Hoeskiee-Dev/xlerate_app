import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:xlerate/core/result.dart';
import 'package:xlerate/domain/entities/task.dart';
import 'package:xlerate/domain/usecases/get_all_tasks/get_all_tasks.dart';
import 'package:xlerate/presentation/providers/usecases/get_all_tasks.dart';
import 'package:xlerate/presentation/providers/user_provider.dart';

part 'tasks_list_provider.g.dart';

@riverpod
class TasksList extends _$TasksList {
  @override
  FutureOr<List<Task>> build() async {
    final user = ref.watch(userProvider);

    if (user == null) return [];

    return _getTasksList(user.id);
  }

  Future<List<Task>> _getTasksList(String userId) async {
    GetAllTasks getAllTasks = ref.read(getAllTasksProvider);

    var result = await getAllTasks(userId);

    return switch (result) {
      Success(value: final tasks) => tasks,
      Failed(message: final msg) => () {
        throw Exception(msg);
      }(),
    };
  }

  // * for local state
  void removeTaskFromState(String taskId) {
    if (state.hasValue) {
      final currentTasks = state.value ?? [];
      state = AsyncData(
        currentTasks.where((task) => task.id != taskId).toList(),
      );
    }
  }

  void updateTaskStatusInState(String taskId, bool isDone) {
    if (state.hasValue) {
      final currentTasks = state.value ?? [];
      state = AsyncData(
        currentTasks.map((task) {
          if (task.id == taskId) {
            return task.copyWith(isDone: isDone);
          }
          return task;
        }).toList(),
      );
    }
  }

  void updateTaskInState(Task updatedTask) {
    if (state.hasValue) {
      final currentTasks = state.value ?? [];
      state = AsyncData(
        currentTasks.map((task) {
          return task.id == updatedTask.id ? updatedTask : task;
        }).toList(),
      );
    }
  }

  Future<void> refresh() async {
    final user = ref.read(userProvider);
    if (user == null) return;

    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _getTasksList(user.id));
  }
}
