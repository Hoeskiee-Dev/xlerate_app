import 'package:flutter/material.dart';
import 'package:xlerate/domain/entities/task.dart';
import 'package:xlerate/domain/entities/task_priority.dart';
import 'package:xlerate/presentation/misc/colors.dart';
import 'package:xlerate/presentation/pages/productivity/methods/task_detail_dialog.dart';

Widget todayTaskCard({
  required Task task,
  required BuildContext context,
  VoidCallback? onTap,
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

  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
    child: InkWell(
      onTap: onTap ?? () => showTaskDetailDialog(context, task),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade300),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // * Task Title
            Text(
              task.title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),

            const SizedBox(height: 6),

            // * Description & Priority Badge
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Text(
                    task.description.isEmpty
                        ? "No description"
                        : task.description,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade600,
                      height: 1.3,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),

                const SizedBox(width: 12),

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: borderColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    task.priority.label,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
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
  );
}
