import 'package:flutter/material.dart';
import '../section_card_widget.dart';
import '../inputs/interactive_field.dart';

class AdministrationSection extends StatelessWidget {
  final String deadlineText;
  final bool createFeedback;
  final VoidCallback onSelectDeadline;
  final Function(bool) onCreateFeedbackChanged;

  const AdministrationSection({
    super.key,
    required this.deadlineText,
    required this.createFeedback,
    required this.onSelectDeadline,
    required this.onCreateFeedbackChanged,
  });

  Widget _buildRadioButton(String label, bool value) {
    return GestureDetector(
      onTap: () => onCreateFeedbackChanged(value),
      child: Row(
        children: [
          Icon(
            createFeedback == value
                ? Icons.radio_button_checked
                : Icons.radio_button_off,
            color: createFeedback == value
                ? const Color(0xFF5E5CE6)
                : Colors.grey,
            size: 20,
          ),
          const SizedBox(width: 4),
          Text(
            label,
            style: const TextStyle(fontSize: 14, color: Colors.black87),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SectionCardWidget(
      title: 'ADMINISTRATION',
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: InteractiveField(
                label: 'Register Deadline *',
                text: deadlineText,
                icon: Icons.event_busy,
                onTap: onSelectDeadline,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Create Feedback Form?',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      _buildRadioButton('Yes', true),
                      const SizedBox(width: 16),
                      _buildRadioButton('No', false),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
