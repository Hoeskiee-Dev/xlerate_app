import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xlerate/domain/entities/task.dart';
import 'package:xlerate/presentation/pages/productivity/methods/today_task_card.dart';

List<Widget> todaysTaskList({
  required AsyncValue<List<Task>> tasksAsync,
  required BuildContext context,
  VoidCallback? onSeeAllPressed,
}) {
  return tasksAsync.when(
    skipLoadingOnRefresh: true,
    data: (tasks) {
      final now = DateTime.now();
      final startOfToday =
          DateTime(now.year, now.month, now.day).millisecondsSinceEpoch ~/ 1000;
      final endOfToday =
          DateTime(
            now.year,
            now.month,
            now.day,
            23,
            59,
            59,
          ).millisecondsSinceEpoch ~/
          1000;

      final todayTasks = tasks.where((task) {
        return task.startDate <= endOfToday && task.endDate >= startOfToday;
      }).toList();

      if (todayTasks.isEmpty) {
        return const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(
              "No tasks for today.",
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
          ),
        ];
      }

      return todayTasks
          .map((task) => todayTaskCard(task: task, context: context))
          .toList();
    },
    loading: () => const [
      Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(child: CircularProgressIndicator()),
      ),
    ],
    error: (err, stack) => [
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          "Failed to load today's tasks",
          style: TextStyle(color: Colors.red.shade400),
        ),
      ),
    ],
  );
}
