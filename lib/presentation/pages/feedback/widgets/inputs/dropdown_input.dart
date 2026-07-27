import 'package:flutter/material.dart';

class DropdownInput extends StatelessWidget {
  final List<dynamic> options;
  final String? selectedOption;
  final Color brandOrange;
  final ValueChanged<String?> onChanged;

  const DropdownInput({
    super.key,
    required this.options,
    required this.selectedOption,
    required this.brandOrange,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      initialValue: selectedOption,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: brandOrange, width: 2),
        ),
      ),
      hint: Text(
        "Select an option",
        style: TextStyle(color: Colors.grey.shade400),
      ),
      items: options.map((opt) {
        String optionText = opt.toString();
        return DropdownMenuItem<String>(
          value: optionText,
          child: Text(optionText, style: const TextStyle(fontSize: 15)),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}
