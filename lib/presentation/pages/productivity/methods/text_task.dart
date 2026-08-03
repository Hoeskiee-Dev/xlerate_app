import 'package:flutter/material.dart';

Padding textTask() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0),
    child: Text(
      "Prove that you are the consistent one.\nCreate task to get focus and stay alert.",
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 15,
      ),
    ),
  );
}
