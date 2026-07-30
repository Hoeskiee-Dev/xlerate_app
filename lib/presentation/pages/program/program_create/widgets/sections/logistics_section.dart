import 'package:flutter/material.dart';
import '../section_card_widget.dart';
import '../inputs/interactive_field.dart';
import '../inputs/filter_chip_widget.dart';
import '../inputs/validated_input_field.dart';

class LogisticsSection extends StatelessWidget {
  final bool isMultiDay;
  final String startDateText;
  final String endDateText;
  final String locationType;
  final String startTimeText;
  final TextEditingController locationController;
  final TextEditingController totalSeatsController;

  final Function(bool) onMultiDayChanged;
  final VoidCallback onSelectStartDate;
  final VoidCallback onSelectEndDate;
  final Function(String) onLocationTypeChanged;
  final VoidCallback onSelectTime;

  const LogisticsSection({
    super.key,
    required this.isMultiDay,
    required this.startDateText,
    required this.endDateText,
    required this.locationType,
    required this.startTimeText,
    required this.locationController,
    required this.totalSeatsController,
    required this.onMultiDayChanged,
    required this.onSelectStartDate,
    required this.onSelectEndDate,
    required this.onLocationTypeChanged,
    required this.onSelectTime,
  });

  @override
  Widget build(BuildContext context) {
    return SectionCardWidget(
      title: 'LOGISTICS',
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Event Duration',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            Row(
              children: [
                const Text('Single', style: TextStyle(fontSize: 12)),
                Switch(
                  value: isMultiDay,
                  activeThumbColor: const Color(0xFF5E5CE6),
                  onChanged: onMultiDayChanged,
                ),
                const Text('Multi-Day', style: TextStyle(fontSize: 12)),
              ],
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: InteractiveField(
                label: 'Start Date *',
                text: startDateText,
                icon: Icons.calendar_today,
                onTap: onSelectStartDate,
              ),
            ),
            if (isMultiDay) ...[
              const SizedBox(width: 16),
              Expanded(
                child: InteractiveField(
                  label: 'End Date *',
                  text: endDateText,
                  icon: Icons.date_range,
                  onTap: onSelectEndDate,
                ),
              ),
            ],
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            FilterChipWidget(
              label: 'In-Person',
              isSelected: locationType == 'In-Person',
              onTap: () => onLocationTypeChanged('In-Person'),
            ),
            FilterChipWidget(
              label: 'Virtual',
              isSelected: locationType == 'Virtual',
              onTap: () => onLocationTypeChanged('Virtual'),
            ),
            FilterChipWidget(
              label: 'Hybrid',
              isSelected: locationType == 'Hybrid',
              onTap: () => onLocationTypeChanged('Hybrid'),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              flex: 3,
              child: ValidatedInputField(
                label: 'Location Details *',
                hint: locationType == 'Virtual'
                    ? 'Zoom/Meet Link'
                    : 'Groove St., Andreas',
                controller: locationController,
                isRequired: true,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              flex: 2,
              child: ValidatedInputField(
                label: 'Available Seats',
                hint: 'Empty means ∞',
                controller: totalSeatsController,
                isNumber: true,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        InteractiveField(
          label: 'Start Time *',
          text: startTimeText,
          icon: Icons.access_time,
          onTap: onSelectTime,
        ),
      ],
    );
  }
}
