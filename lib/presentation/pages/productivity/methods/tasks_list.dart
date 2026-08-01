import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xlerate/domain/entities/task.dart';
import 'package:xlerate/presentation/pages/productivity/methods/task_card.dart';

List<Widget> tasksList({
  required AsyncValue<List<Task>> tasksAsync,
  String selectedPriority = "",
  void Function(Task task, bool? isDone)? onStatusChanged,
  void Function(Task task)? onTap,
  VoidCallback? onRetry,
}) {
  return tasksAsync.when(
    data: (tasks) {
      final filteredTasks = selectedPriority.isEmpty
          ? tasks
          : tasks
                .where(
                  (t) =>
                      t.priority.name.toLowerCase() ==
                      selectedPriority.toLowerCase(),
                )
                .toList();

      if (filteredTasks.isEmpty) {
        return const [
          Padding(
            padding: EdgeInsets.all(24.0),
            child: Center(
              child: Text(
                "No tasks available",
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ),
        ];
      }

      return filteredTasks
          .map(
            (task) => taskCard(
              task: task,
              onStatusChanged: (isDone) => onStatusChanged?.call(task, isDone),
              onTap: () => onTap?.call(task),
            ),
          )
          .toList();
    },

    loading: () => const [
      Padding(
        padding: EdgeInsets.all(32.0),
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    ],

    error: (err, stackTrace) => [
      Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: Column(
            children: [
              Text(
                "Failed to load tasks: ${err.toString().replaceAll('Exception: ', '')}",
                style: const TextStyle(color: Colors.red),
                textAlign: TextAlign.center,
              ),
              if (onRetry != null) ...[
                const SizedBox(height: 8),
                ElevatedButton.icon(
                  onPressed: onRetry,
                  icon: const Icon(Icons.refresh, size: 18),
                  label: const Text("Retry"),
                ),
              ],
            ],
          ),
        ),
      ),
    ],
  );
}
