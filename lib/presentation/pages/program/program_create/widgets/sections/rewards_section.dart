import 'package:flutter/material.dart';
import '../inputs/reward_checkbox.dart';
import '../inputs/validated_input_field.dart';

class RewardsSection extends StatelessWidget {
  final bool offersCertificate;
  final bool offersBadge;
  final bool offersMicroScholarships;
  final bool offersLetterOfRecommendation;
  final bool offersPhysicalSwags;
  final bool offersXleratePoints;
  final TextEditingController xpAmountController;
  final TextEditingController extraRewardController;

  // Callbacks so the main screen knows when a box is checked
  final Function(bool) onCertificateChanged;
  final Function(bool) onBadgeChanged;
  final Function(bool) onMicroScholarshipsChanged;
  final Function(bool) onLetterChanged;
  final Function(bool) onSwagsChanged;
  final Function(bool) onXpChanged;

  const RewardsSection({
    super.key,
    required this.offersCertificate,
    required this.offersBadge,
    required this.offersMicroScholarships,
    required this.offersLetterOfRecommendation,
    required this.offersPhysicalSwags,
    required this.offersXleratePoints,
    required this.xpAmountController,
    required this.extraRewardController,
    required this.onCertificateChanged,
    required this.onBadgeChanged,
    required this.onMicroScholarshipsChanged,
    required this.onLetterChanged,
    required this.onSwagsChanged,
    required this.onXpChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Rewards Offered',
          style: TextStyle(fontSize: 12, color: Colors.black54),
        ),
        Wrap(
          spacing: 12.0,
          runSpacing: -8.0,
          children: [
            RewardCheckbox(
              title: 'Certificate',
              currentValue: offersCertificate,
              onChanged: (val) => onCertificateChanged(val ?? false),
            ),
            RewardCheckbox(
              title: 'Digital Badge',
              currentValue: offersBadge,
              onChanged: (val) => onBadgeChanged(val ?? false),
            ),
            RewardCheckbox(
              title: 'Micro-Scholarships',
              currentValue: offersMicroScholarships,
              onChanged: (val) => onMicroScholarshipsChanged(val ?? false),
            ),
            RewardCheckbox(
              title: 'Letter of Recommendation',
              currentValue: offersLetterOfRecommendation,
              onChanged: (val) => onLetterChanged(val ?? false),
            ),
            RewardCheckbox(
              title: 'Physical Swags',
              currentValue: offersPhysicalSwags,
              onChanged: (val) => onSwagsChanged(val ?? false),
            ),
            RewardCheckbox(
              title: 'Xlerate Points/XP',
              currentValue: offersXleratePoints,
              onChanged: (val) => onXpChanged(val ?? false),
            ),
          ],
        ),
        if (offersXleratePoints) ...[
          const SizedBox(height: 16),
          ValidatedInputField(
            label: 'XP Amount *',
            hint: 'e.g., 500',
            controller: xpAmountController,
            isNumber: true,
            isRequired: true,
          ),
        ],
        const SizedBox(height: 16),
        ValidatedInputField(
          label: 'Extra Rewards (Optional)',
          hint: 'e.g., 1-on-1 Mentorship...',
          controller: extraRewardController,
        ),
      ],
    );
  }
}
