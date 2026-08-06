import 'package:flutter/material.dart';
import 'package:xlerate/domain/entities/task.dart';
import 'package:xlerate/domain/entities/task_priority.dart';
import 'package:xlerate/presentation/misc/colors.dart';

void showTaskDetailDialog(BuildContext context, Task task) {
  showDialog(
    context: context,
    builder: (context) => TaskDetailDialog(task: task),
  );
}

class TaskDetailDialog extends StatelessWidget {
  final Task task;

  const TaskDetailDialog({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final bool isSingleDay = task.formattedStartDate == task.formattedEndDate;

    Color priorityTextColor;
    Color priorityBorderColor;

    switch (task.priority) {
      case TaskPriority.low:
        priorityTextColor = lowPriorityTextColor;
        priorityBorderColor = lowPriorityBorderColor;
        break;
      case TaskPriority.medium:
        priorityTextColor = mediumPriorityTextColor;
        priorityBorderColor = mediumPriorityBorderColor;
        break;
      case TaskPriority.high:
        priorityTextColor = highPriorityTextColor;
        priorityBorderColor = highPriorityBorderColor;
        break;
    }

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      backgroundColor: const Color(
        0xFF38434F,
      ),
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    task.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.close_rounded,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            const Text(
              "Task Description",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              task.description.isEmpty
                  ? "No description provided."
                  : task.description,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 14,
                height: 1.4,
              ),
            ),

            const SizedBox(height: 16),

            Row(
              children: [
                const Text(
                  "Priority: ",
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: priorityBorderColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    task.priority.label,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 11,
                      color: priorityTextColor,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),
            const Divider(color: Colors.white24, height: 1),
            const SizedBox(height: 16),

            if (isSingleDay)
              Center(
                child: Column(
                  children: [
                    const Icon(
                      Icons.calendar_today_rounded,
                      color: Color(0xFF8B5CF6),
                      size: 28,
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Date",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      task.formattedStartDate,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              )
            else
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Start Date",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          task.formattedStartDate,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Row(
                    children: [
                      Text(
                        "- - - ",
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xFF8B5CF6).withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.calendar_today_rounded,
                          color: Color(0xFF8B5CF6),
                          size: 20,
                        ),
                      ),
                      Text(
                        " - - -",
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                    ],
                  ),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text(
                          "End Date",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          task.formattedEndDate,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
