import 'package:flutter/material.dart';

class CheckboxInput extends StatelessWidget {
  final List<dynamic> options;
  final List<String> selectedOptions;
  final Color brandOrange;
  final ValueChanged<List<String>> onChanged;

  const CheckboxInput({
    super.key,
    required this.options,
    required this.selectedOptions,
    required this.brandOrange,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: options.map((opt) {
        String optionText = opt.toString();
        bool isChecked = selectedOptions.contains(optionText);

        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.only(bottom: 8),
          decoration: BoxDecoration(
            color: isChecked
                ? brandOrange.withValues(alpha: .05)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: isChecked ? brandOrange : Colors.transparent,
            ),
          ),
          child: CheckboxListTile(
            title: Text(
              optionText,
              style: TextStyle(
                fontSize: 15,
                color: isChecked ? brandOrange : Colors.black87,
                fontWeight: isChecked ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
            value: isChecked,
            activeColor: brandOrange,
            checkColor: Colors.white,
            controlAffinity: ListTileControlAffinity.trailing,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            onChanged: (val) {
              List<String> updatedList = List.from(selectedOptions);
              if (val == true) {
                updatedList.add(optionText);
              } else {
                updatedList.remove(optionText);
              }
              onChanged(updatedList);
            },
          ),
        );
      }).toList(),
    );
  }
}
