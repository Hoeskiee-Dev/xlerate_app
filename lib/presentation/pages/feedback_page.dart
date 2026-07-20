import 'package:flutter/material.dart';
import 'package:xlerate/data/program_data.dart';

class FeedbackPage extends StatefulWidget {
  final SavedFeedbackForm form;
  const FeedbackPage({super.key, required this.form});

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  final Map<String, dynamic> _answers = {};
  final List<String> _ratingEmojis = ['😡', '😕', '😐', '🙂', '🤩'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Feedback"),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      backgroundColor: Colors.grey.shade100,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // DYNAMIC HEADER
                Center(
                  child: Text(
                    widget.form.title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                // DYNAMIC DESCRIPTION
                if (widget.form.description.isNotEmpty)
                  Center(
                    child: Text(
                      widget.form.description,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),

                const SizedBox(height: 32),

                // 3. THE DYNAMIC ENGINE (Automatically loops through your form data)
                ...widget.form.questions.asMap().entries.map(
                  (entry) =>
                      _buildDynamicQuestion(entry.value, entry.key.toString()),
                ),

                const SizedBox(height: 15),

                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Feedback submitted!"),
                        ),
                      );
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Send Feedback",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDynamicQuestion(SavedQuestion question, String qId) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 28.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question.title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          _buildQuestionInput(question, qId),
        ],
      ),
    );
  }

  Widget _buildQuestionInput(SavedQuestion question, String qId) {
    // EMOJI RATING
    if (question.type == QuestionType.emojiRating) {
      int currentRating = _answers[qId] ?? -1;
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(5, (index) {
          bool isSelected = currentRating == index;
          return GestureDetector(
            onTap: () => setState(() => _answers[qId] = index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? Colors.deepPurple : Colors.grey.shade300,
                  width: isSelected ? 2 : 1,
                ),
                color: isSelected
                    ? Colors.deepPurple.shade100
                    : Colors.transparent,
              ),
              child: Text(
                _ratingEmojis[index],
                style: const TextStyle(fontSize: 30),
              ),
            ),
          );
        }),
      );
    }
    // STAR RATING
    else if (question.type == QuestionType.starRating) {
      int currentStars = _answers[qId] ?? 0;
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(5, (index) {
          bool isFilled = index < currentStars;
          return IconButton(
            icon: Icon(
              isFilled ? Icons.star : Icons.star_border,
              color: Colors.amber,
              size: 36,
            ),
            onPressed: () => setState(() => _answers[qId] = index + 1),
          );
        }),
      );
    }
    // MULTIPLE CHOICE
    else if (question.type == QuestionType.multipleChoice) {
      String? selectedOption = _answers[qId];
      return RadioGroup<String>(
        groupValue: selectedOption,
        onChanged: (val) {
          setState(() {
            _answers[qId] = val;
          });
        },
        child: Column(
          children: question.options.map((opt) {
            return RadioListTile<String>(
              title: Text(
                opt,
                style: const TextStyle(fontSize: 15, color: Colors.black87),
              ),
              value: opt,
              activeColor: Colors.deepPurple,
            );
          }).toList(),
        ),
      );
    }
    // CHECKBOXES
    else if (question.type == QuestionType.checkboxes) {
      List<String> selected = _answers[qId] ?? [];
      return Column(
        children: question.options.map((opt) {
          bool isChecked = selected.contains(opt);
          return Container(
            margin: const EdgeInsets.only(bottom: 8),
            color: isChecked ? Colors.grey.shade100 : Colors.transparent,
            child: CheckboxListTile(
              title: Text(
                opt,
                style: const TextStyle(fontSize: 15, color: Colors.black87),
              ),
              value: isChecked,
              activeColor: Colors.deepPurple,
              controlAffinity: ListTileControlAffinity.trailing,
              onChanged: (val) {
                setState(() {
                  val == true ? selected.add(opt) : selected.remove(opt);
                  _answers[qId] = selected;
                });
              },
            ),
          );
        }).toList(),
      );
    }
    // LINEAR SCALE
    else if (question.type == QuestionType.linearScale) {
      double currentScale = _answers[qId] ?? 3.0;
      return Column(
        children: [
          Slider(
            value: currentScale,
            min: 1,
            max: 5,
            divisions: 4,
            activeColor: Colors.deepPurple,
            label: currentScale.round().toString(),
            onChanged: (val) {
              setState(() {
                _answers[qId] = val;
              });
            },
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "1 (Low)",
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
              Text(
                "5 (High)",
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ],
          ),
        ],
      );
    }
    // 6. Long Answers
    else if (question.type == QuestionType.longText ||
        question.type == QuestionType.shortText) {
      return TextField(
        maxLines: question.type == QuestionType.longText ? 4 : 1,
        decoration: InputDecoration(
          hintText: "Write your feedback here...",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.deepPurple),
          ),
        ),
        onChanged: (val) => _answers[qId] = val,
      );
    }
    // yesNo questions
    else if (question.type == QuestionType.yesNo) {
      String? selectedAnswer = _answers[qId];
      return Row(
        children: ['Yes', 'No'].map((option) {
          bool isSelected = selectedAnswer == option;
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  backgroundColor: isSelected
                      ? Colors.deepPurple.shade100
                      : Colors.transparent,
                  side: BorderSide(
                    color: isSelected
                        ? Colors.deepPurple
                        : Colors.grey.shade300,
                    width: isSelected ? 2 : 1,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                onPressed: () {
                  setState(() {
                    _answers[qId] = option;
                  });
                },
                child: Text(
                  option,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isSelected ? Colors.deepPurple : Colors.black87,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      );
    }
    return const SizedBox();
  }
}
