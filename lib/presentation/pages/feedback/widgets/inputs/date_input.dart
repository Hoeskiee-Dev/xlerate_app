import 'package:flutter/material.dart';

class DateInput extends StatelessWidget {
  final DateTime? selectedDate;
  final Color brandOrange;
  final ValueChanged<DateTime> onChanged;

  const DateInput({
    super.key,
    required this.selectedDate,
    required this.brandOrange,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    String dateText = selectedDate == null
        ? "Select Date"
        : "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}";

    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () async {
        DateTime? picked = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime(2100),
          builder: (context, child) {
            return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: ColorScheme.light(
                  primary: brandOrange,
                  onPrimary: Colors.white,
                  onSurface: Colors.black87,
                ),
              ),
              child: child!,
            );
          },
        );
        if (picked != null) {
          onChanged(picked);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              dateText,
              style: TextStyle(
                fontSize: 16,
                color: selectedDate == null
                    ? Colors.grey.shade400
                    : Colors.black87,
              ),
            ),
            Icon(Icons.calendar_today, color: brandOrange, size: 20),
          ],
        ),
      ),
    );
  }
}
