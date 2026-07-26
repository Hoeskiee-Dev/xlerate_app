import 'package:flutter/material.dart';

class FeedbackSubmitButton extends StatelessWidget {
  final bool isSubmitting;
  final Color brandOrange;
  final Color brandPink;
  final VoidCallback onPressed;

  const FeedbackSubmitButton({
    super.key,
    required this.isSubmitting,
    required this.brandOrange,
    required this.brandPink,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        width: isSubmitting ? 60 : double.infinity,
        height: 55,
        decoration: BoxDecoration(
          gradient: isSubmitting
              ? null
              : LinearGradient(colors: [brandOrange, brandPink]),
          color: isSubmitting ? Colors.grey.shade200 : null,
          borderRadius: BorderRadius.circular(isSubmitting ? 30 : 14),
          boxShadow: isSubmitting
              ? []
              : [
                  BoxShadow(
                    color: brandOrange.withValues(alpha: 0.4),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
          onPressed: isSubmitting ? null : onPressed,
          child: isSubmitting
              ? SizedBox(
                  height: 24,
                  width: 24,
                  child: CircularProgressIndicator(
                    color: brandOrange,
                    strokeWidth: 3,
                  ),
                )
              : const Text(
                  "Send Feedback",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
        ),
      ),
    );
  }
}
