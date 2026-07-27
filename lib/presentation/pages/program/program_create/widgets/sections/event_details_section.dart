import 'package:flutter/material.dart';
import '../section_card_widget.dart';
import '../inputs/validated_input_field.dart';

class EventDetailsSection extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController hostController;
  final TextEditingController speakerController;

  const EventDetailsSection({
    super.key,
    required this.titleController,
    required this.hostController,
    required this.speakerController,
  });

  @override
  Widget build(BuildContext context) {
    return SectionCardWidget(
      title: 'EVENT DETAILS',
      children: [
        ValidatedInputField(
          label: 'Event name *',
          hint: 'e.g. Mastering Database',
          controller: titleController,
          isRequired: true,
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: ValidatedInputField(
                label: 'Held by *',
                hint: 'Excelerate',
                controller: hostController,
                isRequired: true,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ValidatedInputField(
                label: 'Guest/Speaker',
                hint: 'e.g. Alex Uzbek',
                controller: speakerController,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
