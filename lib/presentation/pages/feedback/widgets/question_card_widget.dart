import 'package:flutter/material.dart';
import '../../../../data/program_data.dart';
import 'inputs/star_rating_input.dart';
import 'inputs/emoji_rating_input.dart';
import 'inputs/multiple_choice_input.dart';
import 'inputs/checkbox_input.dart';
import 'inputs/date_input.dart';
import 'inputs/dropdown_input.dart';
import 'inputs/file_upload_input.dart';
import 'inputs/linear_scale_input.dart';
import 'inputs/text_input.dart';
import 'inputs/yes_no_input.dart';

class QuestionCardWidget extends StatelessWidget {
  final SavedQuestion question;
  final String qId;
  final Map<String, dynamic> answers;
  final Color brandOrange;
  final bool showHighlight;
  final ValueChanged<dynamic> onChanged;

  const QuestionCardWidget({
    super.key,
    required this.question,
    required this.qId,
    required this.answers,
    required this.brandOrange,
    required this.showHighlight,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
      margin: const EdgeInsets.only(bottom: 24.0),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: showHighlight
            ? brandOrange.withValues(alpha: .05)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: showHighlight
              ? brandOrange.withValues(alpha: .5)
              : Colors.transparent,
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Question Title
          Text(
            question.title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
            ),
          ),

          // Friendly Error Message Animation
          AnimatedCrossFade(
            firstChild: const SizedBox(height: 0, width: double.infinity),
            secondChild: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(
                children: [
                  Icon(Icons.auto_awesome, size: 16, color: brandOrange),
                  const SizedBox(width: 6),
                  Text(
                    "We'd love your thoughts here! 🥺",
                    style: TextStyle(
                      fontSize: 13,
                      color: brandOrange,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            crossFadeState: showHighlight
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 300),
          ),

          const SizedBox(height: 16),

          // Route to the correct Input Brick
          _buildInputWidget(context),
        ],
      ),
    );
  }

  Widget _buildInputWidget(BuildContext context) {
    if (question.type == QuestionType.starRating) {
      int currentStars = answers[qId] ?? 0;
      return StarRatingInput(
        currentStars: currentStars,
        onChanged: (val) => onChanged(val),
      );
    } else if (question.type == QuestionType.emojiRating) {
      int currentRating = answers[qId] ?? -1;
      return EmojiRatingInput(
        currentRating: currentRating,
        onChanged: (val) => onChanged(val),
      );
    } else if (question.type == QuestionType.multipleChoice) {
      String? selectedOption = answers[qId] as String?;
      return MultipleChoiceInput(
        options: question.options,
        selectedOption: selectedOption,
        brandOrange: brandOrange,
        onChanged: (val) => onChanged(val),
      );
    } else if (question.type == QuestionType.checkboxes) {
      List<String> selectedOptions = List<String>.from(answers[qId] ?? []);
      return CheckboxInput(
        options: question.options,
        selectedOptions: selectedOptions,
        brandOrange: brandOrange,
        onChanged: (val) => onChanged(val),
      );
    } else if (question.type == QuestionType.date) {
      DateTime? selectedDate = answers[qId] as DateTime?;
      return DateInput(
        selectedDate: selectedDate,
        brandOrange: brandOrange,
        onChanged: (val) => onChanged(val),
      );
    } else if (question.type == QuestionType.dropdown) {
      String? selectedOption = answers[qId] as String?;
      return DropdownInput(
        options: question.options,
        selectedOption: selectedOption,
        brandOrange: brandOrange,
        onChanged: (val) => onChanged(val),
      );
    } else if (question.type == QuestionType.fileUpload) {
      String? uploadedFileName = answers[qId] as String?;
      return FileUploadInput(
        uploadedFileName: uploadedFileName,
        brandOrange: brandOrange,
        onChanged: (val) => onChanged(val),
      );
    } else if (question.type == QuestionType.linearScale) {
      double currentScale = answers[qId] ?? 3.0;
      return LinearScaleInput(
        currentScale: currentScale,
        onChanged: (val) => onChanged(val),
      );
    } else if (question.type == QuestionType.shortText ||
        question.type == QuestionType.longText) {
      return TextInput(
        questionType: question.type,
        brandOrange: brandOrange,
        onChanged: (val) => onChanged(val),
      );
    } else if (question.type == QuestionType.yesNo) {
      String? selectedAnswer = answers[qId] as String?;
      return YesNoInput(
        selectedAnswer: selectedAnswer,
        onChanged: (val) => onChanged(val),
      );
    }

    return const SizedBox.shrink();
  }
}
