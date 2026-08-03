import 'package:flutter/material.dart';
import 'package:xlerate/domain/entities/task.dart';
import 'package:xlerate/domain/entities/task_priority.dart';
import 'package:xlerate/presentation/misc/colors.dart';

Widget taskCard({
  required Task task,
  void Function(bool?)? onStatusChanged,
  void Function()? onTap,
  VoidCallback? onDismissed,
}) {
  Color textColor;
  Color borderColor;

  switch (task.priority) {
    case TaskPriority.low:
      textColor = lowPriorityTextColor;
      borderColor = lowPriorityBorderColor;
      break;
    case TaskPriority.medium:
      textColor = mediumPriorityTextColor;
      borderColor = mediumPriorityBorderColor;
      break;
    case TaskPriority.high:
      textColor = highPriorityTextColor;
      borderColor = highPriorityBorderColor;
      break;
  }

  return Dismissible(
    key: ValueKey(task.id),
    direction: DismissDirection.endToStart,
    confirmDismiss: (direction) async {
      return true;
    },
    onDismissed: (direction) {
      if (onDismissed != null) {
        onDismissed.call();
      }
    },
    background: Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          color: Colors.red.shade400,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Icon(
          Icons.delete_outline,
          color: Colors.white,
          size: 28,
        ),
      ),
    ),
    child: Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                blurRadius: 1,
                offset: const Offset(2, 4),
                color: Colors.grey.shade200,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // * Checkbox & task name
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Checkbox(
                    value: task.isDone,
                    onChanged: onStatusChanged,
                  ),
                  Expanded(
                    child: Text(
                      task.title,
                      style: TextStyle(
                        fontSize: 17,
                        decoration: task.isDone
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                        color: task.isDone ? Colors.grey : Colors.black,
                      ),
                    ),
                  ),
                ],
              ),

              // * End date & Priority badge
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 16,
                      right: 16,
                      bottom: 8,
                    ),
                    child: Text(
                      task.formattedEndDate,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: borderColor,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      task.priority.label,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
