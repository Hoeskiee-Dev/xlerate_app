import 'package:flutter/material.dart';

Widget feedbackButton({
  required bool isEventEnded,
  bool isSubmitted = false,
  required Function()? onPressed,
}) {
  String buttonText;

  if (isSubmitted) {
    buttonText = "Feedback Submitted";
  } else if (isEventEnded) {
    buttonText = "Submit Feedback";
  } else {
    buttonText = "Feedback Closed";
  }

  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: isSubmitted ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFFFF0EC),
          foregroundColor: const Color(0xFFFF6A3D),
          disabledBackgroundColor: isSubmitted
              ? Colors.green.shade100
              : Colors.grey.shade300,
          disabledForegroundColor: isSubmitted
              ? Colors.green.shade800
              : Colors.grey.shade600,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          buttonText,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
  );
}
