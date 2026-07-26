import 'package:flutter/material.dart';
import 'package:xlerate/data/program_data.dart';

class TextInput extends StatelessWidget {
  final QuestionType questionType;
  final Color brandOrange;
  final ValueChanged<String> onChanged;

  const TextInput({
    super.key,
    required this.questionType,
    required this.brandOrange,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    // Explicitly handle both short answer and paragraph (long text)
    bool isParagraph = questionType == QuestionType.longText;

    return TextField(
      maxLines: isParagraph
          ? 4
          : 1, // 1 line for short answer, 4 lines for paragraph
      decoration: InputDecoration(
        hintText: isParagraph
            ? "Write your detailed feedback here..."
            : "Write your short answer here...",
        hintStyle: TextStyle(color: Colors.grey.shade400),
        filled: true,
        fillColor: Colors.grey.shade50,
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
      onChanged: onChanged,
    );
  }
}
