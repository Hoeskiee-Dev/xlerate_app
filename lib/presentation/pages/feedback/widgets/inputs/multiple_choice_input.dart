import 'package:flutter/material.dart';

class MultipleChoiceInput extends StatelessWidget {
  final List<dynamic> options;
  final String? selectedOption;
  final Color brandOrange;
  final ValueChanged<String> onChanged;

  const MultipleChoiceInput({
    super.key,
    required this.options,
    required this.selectedOption,
    required this.brandOrange,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return RadioGroup<String>(
      groupValue: selectedOption,
      onChanged: (String? val) {
        if (val != null) {
          onChanged(val);
        }
      },
      child: Column(
        children: options.map<Widget>((opt) {
          final String optionText = opt.toString();
          final bool isSelected = selectedOption == optionText;

          return AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            margin: const EdgeInsets.only(bottom: 8),
            decoration: BoxDecoration(
              color: isSelected
                  ? brandOrange.withValues(alpha: 0.12)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: isSelected ? brandOrange : Colors.transparent,
              ),
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () => onChanged(optionText),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12.0,
                  vertical: 10.0,
                ),
                child: Row(
                  children: [
                    Radio<String>(
                      value: optionText,
                      activeColor: brandOrange,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        optionText,
                        style: TextStyle(
                          fontSize: 15,
                          color: isSelected ? brandOrange : Colors.black87,
                          fontWeight: isSelected
                              ? FontWeight.w600
                              : FontWeight.normal,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
