import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Widget dateRange({
  required BuildContext context,
  DateTime? startDate,
  DateTime? endDate,
  bool isAllDay = false,
  required ValueChanged<DateTime> onStartDateSelected,
  required ValueChanged<DateTime> onEndDateSelected,
  required ValueChanged<bool?> onAllDayChanged,
}) => Padding(
  padding: const EdgeInsets.symmetric(horizontal: 16),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            "Task Date",
            style: TextStyle(
              color: Colors.grey.shade600,
            ),
          ),
          Row(
            children: [
              Checkbox(
                value: isAllDay,
                onChanged: onAllDayChanged,
              ),
              const Text(
                "All day?",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),

      const SizedBox(height: 4),

      Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade400),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            _datePickerTile(
              context: context,
              icon: Icons.date_range,
              hintText: isAllDay ? "Date" : "Start date",
              selectedDate: startDate,
              onDatePicked: onStartDateSelected,
            ),

            if (!isAllDay) ...[
              const Divider(height: 1),

              _datePickerTile(
                context: context,
                icon: Icons.date_range_outlined,
                hintText: "End date",
                selectedDate: endDate,
                minDate: startDate,
                onDatePicked: onEndDateSelected,
              ),
            ],
          ],
        ),
      ),
    ],
  ),
);

Widget _datePickerTile({
  required BuildContext context,
  required IconData icon,
  required String hintText,
  required DateTime? selectedDate,
  required ValueChanged<DateTime> onDatePicked,
  DateTime? minDate,
}) {
  return InkWell(
    borderRadius: BorderRadius.circular(12),
    onTap: () async {
      final now = DateTime.now();

      DateTime calculatedFirstDate = minDate ?? DateTime(2020);

      if (selectedDate != null && selectedDate.isBefore(calculatedFirstDate)) {
        calculatedFirstDate = DateTime(
          selectedDate.year,
          selectedDate.month,
          selectedDate.day,
        );
      }

      final DateTime initial = selectedDate ?? (minDate ?? now);
      final DateTime safeInitialDate = initial.isBefore(calculatedFirstDate)
          ? calculatedFirstDate
          : initial;

      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: safeInitialDate,
        firstDate: calculatedFirstDate,
        lastDate: DateTime(2030),
      );

      if (picked != null) {
        onDatePicked(picked);
      }
    },
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.grey.shade700),
          const SizedBox(width: 12),
          Text(
            selectedDate != null
                ? DateFormat('dd MMMM yyyy').format(selectedDate)
                : hintText,
            style: TextStyle(
              fontSize: 16,
              color: selectedDate != null
                  ? Colors.black87
                  : Colors.grey.shade400,
            ),
          ),
        ],
      ),
    ),
  );
}
