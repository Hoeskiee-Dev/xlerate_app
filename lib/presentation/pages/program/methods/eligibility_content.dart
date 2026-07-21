import 'package:flutter/material.dart';
import 'package:xlerate/presentation/misc/methods.dart';
import 'package:xlerate/data/program_data.dart';

Widget eligibilityContent(Program program) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "Who can apply?",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
      verticalSpaces(8),
      Text("• ${program.eligibility}"),
    ],
  );
}
