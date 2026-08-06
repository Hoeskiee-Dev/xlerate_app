import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xlerate/domain/entities/task.dart';
import 'package:xlerate/presentation/pages/productivity/methods/task_card.dart';

List<Widget> tasksList({
  required AsyncValue<List<Task>> tasksAsync,
  required BuildContext context,
  String selectedPriority = "",
  String searchQuery = "",
  void Function(Task task, bool? isDone)? onStatusChanged,
  void Function(Task task)? onTap,
  void Function(Task task)? onDelete,
  void Function(Task task)? onEdit,
  VoidCallback? onRetry,
}) {
  return tasksAsync.when(
    skipLoadingOnRefresh: true,
    skipLoadingOnReload: true,
    data: (tasks) {
      final filteredTasks = tasks.where((t) {
        final matchesPriority =
            selectedPriority.isEmpty ||
            t.priority.name.toLowerCase() == selectedPriority.toLowerCase();

        final matchesSearch =
            searchQuery.isEmpty ||
            t.title.toLowerCase().contains(searchQuery.toLowerCase());

        return matchesPriority && matchesSearch;
      }).toList();

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

      filteredTasks.sort((a, b) {
        if (a.isDone == b.isDone) {
          return a.endDate.compareTo(b.endDate);
        }
        return a.isDone ? 1 : -1;
      });

      return filteredTasks
          .map(
            (task) => taskCard(
              context: context,
              task: task,
              onStatusChanged: (isDone) => onStatusChanged?.call(task, isDone),
              onTap: onTap != null ? () => onTap(task) : null,
              onDeletePressed: () => onDelete?.call(task),
              onEditPressed: () => onEdit?.call(task),
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
