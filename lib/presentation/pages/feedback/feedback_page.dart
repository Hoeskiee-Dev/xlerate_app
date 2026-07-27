import 'package:flutter/material.dart';
import 'package:xlerate/domain/entities/question_type.dart';
import 'package:xlerate/domain/entities/saved_feedback_form.dart';
import 'package:xlerate/domain/entities/saved_question.dart';
import 'widgets/feedback_header_widget.dart';
import 'widgets/question_card_widget.dart';
import 'widgets/feedback_submit_button.dart';

class FeedbackPage extends StatefulWidget {
  final SavedFeedbackForm form;
  const FeedbackPage({super.key, required this.form});

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  final Map<String, dynamic> _answers = {};

  // Brand Colors
  final Color _brandOrange = const Color(0xFFFF6B00);
  final Color _brandPink = const Color(0xFFF03737);

  bool _showErrors = false;
  bool _isSubmitting = false;

  void _handleSubmit() async {
    // Validate: Check if every question has an answer
    bool allAnswered = widget.form.questions.asMap().keys.every((index) {
      final val = _answers[index.toString()];
      if (val == null) return false;
      if (val is String && val.trim().isEmpty) return false;
      if (val is List && val.isEmpty) return false;
      return true;
    });

    if (!allAnswered) {
      // Trigger friendly errors
      setState(() => _showErrors = true);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.black87,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          content: const Row(
            children: [
              Icon(Icons.sentiment_dissatisfied, color: Colors.orangeAccent),
              SizedBox(width: 10),
              // FIX: Wrapped in Expanded so it can drop to a new line if needed
              Expanded(
                child: Text("Oops! Looks like you missed a few questions."),
              ),
            ],
          ),
        ),
      );
      return;
    }

    setState(() {
      _showErrors = false;
      _isSubmitting = true;
    });

    await Future.delayed(const Duration(seconds: 2));

    // Success state
    if (mounted) {
      setState(() => _isSubmitting = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.green.shade600,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          content: const Row(
            children: [
              Icon(Icons.check_circle, color: Colors.white),
              SizedBox(width: 10),
              Expanded(
                child: Text("Thank you! Your feedback helps us grow. 🚀"),
              ),
            ],
          ),
        ),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text("Feedback"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black87,
        elevation: 0,
      ),
      // Branded Aura Background
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              _brandOrange.withAlpha(35),
              Colors.grey.shade50,
              _brandPink.withAlpha(25),
            ],
            stops: const [0.0, 0.5, 1.0],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(20),
            child: Card(
              elevation: 8,
              shadowColor: _brandOrange.withAlpha(30),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 1. BRANDED HEADER WIDGET
                    FeedbackHeaderWidget(
                      title: widget.form.title,
                      description: widget.form.description,
                      brandOrange: _brandOrange,
                      brandPink: _brandPink,
                    ),

                    const SizedBox(height: 30),

                    // 2. DYNAMIC QUESTION CARDS
                    ...widget.form.questions.asMap().entries.map((entry) {
                      final qId = entry.key.toString();
                      final question = entry.value;

                      bool hasAnswer =
                          _answers[qId] != null &&
                          (_answers[qId] is String
                              ? _answers[qId].trim().isNotEmpty
                              : true) &&
                          (_answers[qId] is List
                              ? _answers[qId].isNotEmpty
                              : true);

                      return QuestionCardWidget(
                        question: question,
                        qId: qId,
                        answers: _answers,
                        brandOrange: _brandOrange,
                        showHighlight: _showErrors && !hasAnswer,
                        onChanged: (val) {
                          setState(() {
                            _answers[qId] = val;
                            if (_showErrors) _showErrors = false;
                          });
                        },
                      );
                    }),

                    const SizedBox(height: 20),

                    // 3. SUBMIT BUTTON WIDGET
                    FeedbackSubmitButton(
                      isSubmitting: _isSubmitting,
                      brandOrange: _brandOrange,
                      brandPink: _brandPink,
                      onPressed: _handleSubmit,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
