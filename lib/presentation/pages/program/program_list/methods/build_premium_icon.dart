import 'package:flutter/material.dart';

Widget buildPremiumIcon(
  IconData icon,
  Color color,
  LinearGradient outlineGradient,
) {
  return Container(
    width: 20,
    height: 20,
    padding: const EdgeInsets.all(1.5),
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      gradient: outlineGradient, // Premium dual-tone edge
    ),
    child: Container(
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white, // White core to maintain icon visibility
      ),
      child: Icon(
        icon,
        size: 11, // Properly scaled internal Icon
        color: color,
      ),
    ),
  );
}
