import 'package:flutter/material.dart';

class FeedbackHeaderWidget extends StatelessWidget {
  final String title;
  final String description;
  final Color brandOrange;
  final Color brandPink;

  const FeedbackHeaderWidget({
    super.key,
    required this.title,
    required this.description,
    required this.brandOrange,
    required this.brandPink,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: ShaderMask(
            blendMode: BlendMode.srcIn,
            shaderCallback: (bounds) => LinearGradient(
              colors: [brandOrange, brandPink],
            ).createShader(bounds),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w900,
                color: Colors.white,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        if (description.isNotEmpty)
          Center(
            child: Text(
              description,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 14,
                height: 1.5,
              ),
            ),
          ),
      ],
    );
  }
}
