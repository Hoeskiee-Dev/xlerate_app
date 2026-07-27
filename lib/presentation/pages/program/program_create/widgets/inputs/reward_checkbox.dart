import 'package:flutter/material.dart';

class RewardCheckbox extends StatelessWidget {
  final String title;
  final bool currentValue;
  final Function(bool?) onChanged;

  const RewardCheckbox({
    super.key,
    required this.title,
    required this.currentValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Checkbox(
            value: currentValue,
            onChanged: onChanged,
            activeColor: const Color(0xFF5E5CE6), // Xlerate Purple
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          Text(title, style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }
}
