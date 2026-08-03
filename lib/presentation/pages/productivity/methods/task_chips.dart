import 'package:flutter/material.dart';

Widget taskChips({
  required String selectedPriority,
  required Function(String) onSelected,
}) {
  final priorities = ['Low', 'Medium', 'High'];

  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: priorities.map((priority) {
        final isSelected = selectedPriority == priority;

        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: GestureDetector(
              onTap: () => onSelected(priority),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isSelected
                      ? const Color(0xFF1E293B)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected
                        ? const Color(0xFF64748B)
                        : Colors.grey.shade500,
                    width: 1.5,
                  ),
                ),
                child: Text(
                  priority,
                  style: TextStyle(
                    color: isSelected ? Colors.white : const Color(0xFF94A3B8),
                    fontSize: 14,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  ),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    ),
  );
}
