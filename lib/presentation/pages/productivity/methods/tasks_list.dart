import 'package:flutter/material.dart';
import 'package:xlerate/domain/entities/task.dart';
import 'package:xlerate/presentation/pages/productivity/methods/task_card.dart';

List<Widget> tasksList({
  required List<Task> tasks,
  void Function(Task task, bool? isDone)? onStatusChanged,
  void Function(Task task)? onTap,
}) {
  if (tasks.isEmpty) {
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

  return tasks
      .map(
        (task) => taskCard(
          task: task,
          onStatusChanged: (isDone) => onStatusChanged?.call(task, isDone),
          onTap: () => onTap?.call(task),
        ),
      )
      .toList();
}
