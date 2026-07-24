import 'package:flutter/material.dart';
import 'package:xlerate/presentation/misc/methods.dart';
import 'package:xlerate/data/program_data.dart';

Widget rewardsContent(Program program) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        "Program Rewards",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),

      verticalSpaces(8),

      if (program.offersCertificate)
        const Text("✅ E-Certificate of Completion"),

      if (program.offersBadge) const Text("✅ Digital Badge"),

      if (program.offersMicroScholarships) const Text("✅ Micro-Scholarships"),

      if (program.offersLetterOfRecommendation)
        const Text("✅ Letter of Recommendation"),

      if (program.offersPhysicalSwags)
        const Text("✅ Physical Swags / Merch Boxes"),

      if (program.offersXleratePoints)
        Text("✅ ${program.xpAmount ?? 0} Xlerate Points (XP)"),

      if (program.extraReward != null && program.extraReward!.isNotEmpty)
        Text("✅ ${program.extraReward}"),

      // Fallback message just in case the admin didn't select ANY rewards
      if (!program.offersCertificate &&
          !program.offersBadge &&
          !program.offersMicroScholarships &&
          !program.offersLetterOfRecommendation &&
          !program.offersPhysicalSwags &&
          !program.offersXleratePoints &&
          (program.extraReward == null || program.extraReward!.isEmpty))
        const Text(
          "No specific rewards listed for this program.",
          style: TextStyle(fontStyle: FontStyle.italic, color: Colors.grey),
        ),

      verticalSpaces(16),

      const Text(
        "Skills Gain",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),

      verticalSpaces(8),

      // Safety check in case the skills list is empty
      if (program.skills.isEmpty)
        const Text(
          "No specific skills listed.",
          style: TextStyle(fontStyle: FontStyle.italic, color: Colors.grey),
        )
      else
        ...program.skills.map((skill) => Text("• $skill")),
    ],
  );
}
