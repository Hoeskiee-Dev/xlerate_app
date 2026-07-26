import 'package:flutter/material.dart';

class LinearScaleInput extends StatelessWidget {
  final double currentScale;
  final ValueChanged<double> onChanged;

  const LinearScaleInput({
    super.key,
    required this.currentScale,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    double normalizedValue = (currentScale - 1) / 4;
    Color dynamicColor =
        Color.lerp(
          Colors.red.shade500,
          Colors.green.shade600,
          normalizedValue,
        ) ??
        Colors.green;

    return Column(
      children: [
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: dynamicColor,
            inactiveTrackColor: dynamicColor.withValues(alpha: .2),
            thumbColor: dynamicColor,
            overlayColor: dynamicColor.withValues(alpha: .2),
            valueIndicatorColor: dynamicColor,
            trackHeight: 6,
          ),
          child: Slider(
            value: currentScale,
            min: 1,
            max: 5,
            divisions: 4,
            label: currentScale.round().toString(),
            onChanged: onChanged,
          ),
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "1 (Low)",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "5 (High)",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
