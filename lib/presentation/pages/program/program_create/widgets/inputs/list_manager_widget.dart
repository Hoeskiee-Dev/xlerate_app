import 'package:flutter/material.dart';

class ListManagerWidget extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final List<String> selectedList;
  final List<String> suggestedList;
  final Color chipColor;
  final Function(String) onAdd;
  final Function(String) onRemove;

  const ListManagerWidget({
    super.key,
    required this.label,
    required this.hint,
    required this.controller,
    required this.selectedList,
    required this.suggestedList,
    this.chipColor = const Color(0xFF5E5CE6), // Default Xlerate Purple
    required this.onAdd,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: Colors.black54),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 14,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            suffixIcon: IconButton(
              icon: Icon(Icons.add_circle, color: chipColor),
              onPressed: () {
                final text = controller.text.trim();
                if (text.isNotEmpty && !selectedList.contains(text)) {
                  onAdd(text);
                  controller.clear();
                }
              },
            ),
          ),
        ),

        // Render Selected Chips
        if (selectedList.isNotEmpty) ...[
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: selectedList
                .map(
                  (item) => Chip(
                    label: Text(
                      item,
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                    backgroundColor: chipColor,
                    deleteIcon: const Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 16,
                    ),
                    onDeleted: () => onRemove(item),
                  ),
                )
                .toList(),
          ),
        ],
        const SizedBox(height: 12),

        // Render Suggested Horizontally Scrollable Chips
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: suggestedList.map((item) {
              final isSelected = selectedList.contains(item);
              return GestureDetector(
                onTap: () {
                  if (isSelected) {
                    onRemove(item);
                  } else {
                    onAdd(item);
                  }
                },
                child: Container(
                  margin: const EdgeInsets.only(right: 8),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? chipColor.withValues(alpha: 0.1)
                        : Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: isSelected ? chipColor : Colors.grey.shade300,
                    ),
                  ),
                  child: Text(
                    item,
                    style: TextStyle(
                      color: isSelected ? chipColor : Colors.black87,
                      fontSize: 12,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
