import 'package:flutter/material.dart';

class YesNoInput extends StatelessWidget {
  final String? selectedAnswer;
  final ValueChanged<String> onChanged;

  const YesNoInput({
    super.key,
    required this.selectedAnswer,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // --- YES BUTTON ---
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () => onChanged("Yes"),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: selectedAnswer == "Yes"
                      ? Colors.green.shade600
                      : Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: selectedAnswer == "Yes"
                        ? Colors.green.shade600
                        : Colors.grey.shade300,
                    width: selectedAnswer == "Yes" ? 2 : 1,
                  ),
                  boxShadow: selectedAnswer == "Yes"
                      ? [
                          BoxShadow(
                            color: Colors.green.withAlpha(50),
                            blurRadius: 8,
                            spreadRadius: 2,
                          ),
                        ]
                      : [],
                ),
                alignment: Alignment.center,
                child: Text(
                  "Yes",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: selectedAnswer == "Yes"
                        ? Colors.white
                        : Colors.black87,
                  ),
                ),
              ),
            ),
          ),
        ),

        // --- NO BUTTON ---
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () => onChanged("No"),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: selectedAnswer == "No"
                      ? Colors.red.shade500
                      : Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: selectedAnswer == "No"
                        ? Colors.red.shade500
                        : Colors.grey.shade300,
                    width: selectedAnswer == "No" ? 2 : 1,
                  ),
                  boxShadow: selectedAnswer == "No"
                      ? [
                          BoxShadow(
                            color: Colors.red.withAlpha(50),
                            blurRadius: 8,
                            spreadRadius: 2,
                          ),
                        ]
                      : [],
                ),
                alignment: Alignment.center,
                child: Text(
                  "No",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: selectedAnswer == "No"
                        ? Colors.white
                        : Colors.black87,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
