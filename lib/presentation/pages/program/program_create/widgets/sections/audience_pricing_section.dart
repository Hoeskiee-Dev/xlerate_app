import 'package:flutter/material.dart';
import '../section_card_widget.dart';
import '../inputs/validated_input_field.dart';

class AudiencePricingSection extends StatelessWidget {
  final TextEditingController eligibilityController;
  final TextEditingController feeController;
  final bool isFree;
  final Function(bool) onIsFreeChanged;

  const AudiencePricingSection({
    super.key,
    required this.eligibilityController,
    required this.feeController,
    required this.isFree,
    required this.onIsFreeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SectionCardWidget(
      title: 'AUDIENCE & PRICING',
      children: [
        ValidatedInputField(
          label: 'Eligibility / Target Audience',
          hint: 'e.g. 8th to 10th Graders Only',
          controller: eligibilityController,
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Participation Fee',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            Row(
              children: [
                const Text('Paid', style: TextStyle(fontSize: 12)),
                Switch(
                  value: isFree,
                  activeThumbColor: Colors.green,
                  onChanged: onIsFreeChanged,
                ),
                const Text(
                  'Free',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ],
        ),
        if (!isFree) ...[
          const SizedBox(height: 8),
          ValidatedInputField(
            label: 'Price (\$)',
            hint: '0.00',
            controller: feeController,
            isNumber: true,
            isRequired: true,
          ),
        ],
      ],
    );
  }
}
