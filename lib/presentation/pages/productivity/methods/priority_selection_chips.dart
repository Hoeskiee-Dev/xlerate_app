import 'package:flutter/material.dart';
import 'package:xlerate/domain/entities/task_priority.dart';
import 'package:xlerate/presentation/misc/colors.dart';
import 'package:xlerate/presentation/misc/methods.dart';

Widget prioritySelectionChips({
  required TaskPriority? selectedPriority,
  required ValueChanged<TaskPriority> onSelected,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Task Priority",
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 14,
          ),
        ),

        verticalSpaces(8),

        Row(
          children: TaskPriority.values.map((priority) {
            final isSelected = selectedPriority == priority;

            final label =
                priority.name[0].toUpperCase() + priority.name.substring(1);

            final colors = _getPriorityColors(priority);

            return Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () => onSelected(priority),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? colors.borderColor
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isSelected
                              ? colors.borderColor
                              : Colors.black26,
                          width: 1.5,
                        ),
                      ),
                      child: Text(
                        label,
                        style: TextStyle(
                          color: isSelected ? colors.textColor : Colors.black87,
                          fontWeight: isSelected
                              ? FontWeight.bold
                              : FontWeight.normal,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    ),
  );
}

({Color textColor, Color borderColor}) _getPriorityColors(
  TaskPriority priority,
) {
  return switch (priority) {
    TaskPriority.low => (
      textColor: lowPriorityTextColor,
      borderColor: lowPriorityBorderColor,
    ),
    TaskPriority.medium => (
      textColor: mediumPriorityTextColor,
      borderColor: mediumPriorityBorderColor,
    ),
    TaskPriority.high => (
      textColor: highPriorityTextColor,
      borderColor: highPriorityBorderColor,
    ),
  };
}
