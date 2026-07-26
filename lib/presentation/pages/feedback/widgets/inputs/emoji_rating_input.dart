import 'package:flutter/material.dart';

class EmojiRatingInput extends StatelessWidget {
  final int currentRating;
  final ValueChanged<int> onChanged;

  const EmojiRatingInput({
    super.key,
    required this.currentRating,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final List<String> ratingEmojis = ['😡', '😕', '😐', '🙂', '🤩'];
    final List<Color> sentimentColors = [
      Colors.red.shade500, // 😡
      Colors.orange.shade500, // 😕
      Colors.amber.shade500, // 😐
      Colors.lightGreen.shade500, // 🙂
      Colors.green.shade600, // 🤩
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(5, (index) {
          bool isSelected = currentRating == index;
          Color activeColor = sentimentColors[index];

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3.4),
            child: GestureDetector(
              onTap: () => onChanged(index),
              child: AnimatedScale(
                scale: isSelected ? 1.15 : 1.0,
                duration: const Duration(milliseconds: 200),
                curve: Curves.elasticOut,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.all(
                    6,
                  ),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isSelected ? activeColor : Colors.grey.shade200,
                      width: isSelected ? 2 : 1,
                    ),
                    color: isSelected
                        ? activeColor.withValues(alpha: 0.15)
                        : Colors.white,
                    boxShadow: isSelected
                        ? [
                            BoxShadow(
                              color: activeColor.withValues(alpha: .3),
                              blurRadius: 6,
                              spreadRadius: 1,
                            ),
                          ]
                        : [],
                  ),
                  child: Text(
                    ratingEmojis[index],
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
