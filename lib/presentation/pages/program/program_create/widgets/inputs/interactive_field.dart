import 'package:flutter/material.dart';

class InteractiveField extends StatelessWidget {
  final String label;
  final String text;
  final IconData icon;
  final VoidCallback onTap;

  const InteractiveField({
    super.key,
    required this.label,
    required this.text,
    required this.icon,
    required this.onTap,
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
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  text,
                  style: TextStyle(
                    // Logic to gray out placeholder text
                    color: text.contains('Select') || text.contains('Set')
                        ? Colors.grey.shade400
                        : Colors.black87,
                    fontSize: 14,
                  ),
                ),
                Icon(icon, color: Colors.grey.shade400, size: 20),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
