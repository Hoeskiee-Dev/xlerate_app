import 'package:flutter/material.dart';

class StarRatingInput extends StatelessWidget {
  final int currentStars;
  final ValueChanged<int> onChanged;

  const StarRatingInput({
    super.key,
    required this.currentStars,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(5, (index) {
          bool isFilled = index < currentStars;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: GestureDetector(
              onTap: () => onChanged(index + 1),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (child, anim) =>
                    ScaleTransition(scale: anim, child: child),
                child: Icon(
                  isFilled ? Icons.star_rounded : Icons.star_border_rounded,
                  key: ValueKey(isFilled),
                  color: isFilled ? Colors.amber : Colors.grey.shade300,
                  size: 34,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
