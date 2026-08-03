import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:xlerate/domain/entities/task.dart';
import 'package:xlerate/domain/entities/task_priority.dart';
import 'package:xlerate/presentation/misc/colors.dart';

Widget taskCard({
  required Task task,
  void Function(bool?)? onStatusChanged,
  void Function()? onTap,
  VoidCallback? onDeletePressed,
  VoidCallback? onEditPressed,
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
    padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
    child: PhysicalModel(
      color:
          Colors.transparent, // Transparan agar warna mengikuti isi di dalamnya
      elevation: 3, // 💡 Atur ketebalan shadow di sini (misal: 2 - 4)
      shadowColor: Colors.black.withOpacity(0.2), // Warna shadow soft
      borderRadius: BorderRadius.circular(
        16,
      ), // Sudut shadow bulat mengikuti outer card
      clipBehavior: Clip.antiAlias,
      child: Slidable(
        key: ValueKey(task.id),
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            // * Edit button
            SlidableAction(
              onPressed: (context) {
                if (onEditPressed != null) onEditPressed();
              },
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              icon: Icons.edit,
              label: 'Edit',
              borderRadius: BorderRadius.zero,
            ),

            // * Delete button
            SlidableAction(
              onPressed: (context) {
                if (onDeletePressed != null) onDeletePressed();
              },
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
              borderRadius: const BorderRadius.horizontal(
                right: Radius.circular(16),
              ),
            ),
          ],
        ),

        child: GestureDetector(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
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
    ),
  );
}
