import 'package:flutter/material.dart';
import 'package:xlerate/presentation/misc/methods.dart';
import 'package:xlerate/domain/entities/program.dart';

Widget rewardsContent(Program program) {
  // Helper widget to keep reward rows clean and consistent
  Widget buildRewardRow(IconData icon, Color iconColor, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(icon, size: 18, color: iconColor),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        "Program Rewards",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),

      verticalSpaces(8),

      // Rewards use contextual icons
      if (program.offersCertificate)
        buildRewardRow(
          Icons.card_membership,
          Colors.blue,
          "E-Certificate of Completion",
        ),

      if (program.offersBadge)
        buildRewardRow(
          Icons.shield,
          const Color.fromARGB(255, 100, 6, 250),
          "Digital Badge",
        ),

      if (program.offersMicroScholarships)
        buildRewardRow(Icons.school, Colors.purple, "Micro-Scholarships"),

      if (program.offersLetterOfRecommendation)
        buildRewardRow(
          Icons.description,
          Colors.teal,
          "Letter of Recommendation",
        ),

      if (program.offersPhysicalSwags)
        buildRewardRow(
          Icons.card_giftcard,
          Colors.orange,
          "Physical Swags / Merch Boxes",
        ),

      if (program.offersXleratePoints)
        buildRewardRow(
          Icons.stars,
          Colors.deepOrange,
          "${program.xpAmount ?? 0} Xlerate Points (XP)",
        ),

      if (program.extraReward != null && program.extraReward!.isNotEmpty)
        buildRewardRow(
          Icons.verified,
          Colors.green,
          "${program.extraReward}",
        ),

      // Fallback message just in case the admin didn't select ANY rewards
      if (!program.offersCertificate &&
          !program.offersBadge &&
          !program.offersMicroScholarships &&
          !program.offersLetterOfRecommendation &&
          !program.offersPhysicalSwags &&
          !program.offersXleratePoints &&
          (program.extraReward == null || program.extraReward!.isEmpty))
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 4.0),
          child: Text(
            "No specific rewards listed for this program.",
            style: TextStyle(fontStyle: FontStyle.italic, color: Colors.grey),
          ),
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
        ...program.skills.map(
          (skill) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 2.0),
            child: Text("• $skill"),
          ),
        ),
    ],
  );
}
