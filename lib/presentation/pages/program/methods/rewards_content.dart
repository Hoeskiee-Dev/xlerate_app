import 'package:flutter/material.dart';
import 'package:xlerate/presentation/misc/methods.dart';
import 'package:xlerate/data/program_data.dart';

Widget rewardsContent(Program program) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "Program Rewards",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),

      verticalSpaces(8),

      Text("✅ E-Certificate of Completion"),
      Text("✅ Internship opportunity at Excelerate"),
      Text("✅ Free Mentorship Session"),

      verticalSpaces(16),

      Text(
        "Skills Gain",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),

      verticalSpaces(8),
      ...program.skills.map((skill) => Text("• $skill")),
    ],
  );
}
