import 'package:flutter/material.dart';
import 'package:xlerate/domain/entities/program.dart';

import 'package:xlerate/presentation/pages/program/program_detail/program_detail_page.dart';
import 'package:xlerate/presentation/pages/program/program_list/methods/build_premium_icon.dart';

final LinearGradient _brandGradient = const LinearGradient(
  colors: [
    Colors.redAccent, // Start color (Left)
    Colors.orangeAccent, // End color (Right)
  ],
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
);

/// Constructs the primary Program Card layout.
Widget buildProgramCard(BuildContext context, Program program) {
  // --- PRE-CALCULATE LIVE SPOTS ---
  int? total = program.totalSeats;
  int joined = program.joinedCount;
  Color spotsColor;
  String spotsText;

  if (total == null) {
    spotsColor = Colors.green.shade600;
    spotsText = 'No Limit';
  } else {
    int spotsLeft = total - joined;
    if (spotsLeft <= 0) {
      spotsColor = Colors.grey.shade500;
      spotsText = 'No Spots Left';
    } else {
      spotsText = '$spotsLeft Spots Left';
      double percentage = spotsLeft / total;

      // Dynamically style based on urgency (filling up)
      if (percentage >= 0.5) {
        spotsColor = Colors.green.shade600; // Plenty of room
      } else if (percentage >= 0.25) {
        spotsColor = Colors.amber.shade700; // Filling up
      } else {
        spotsColor = Colors.red.shade600; // Almost full
      }
    }
  }

  // --- PRE-CALCULATE DEADLINE SAFETY ---
  // Guarantees we never pass a null value to the Text widget
  final String deadlineText =
      (program.registrationDeadLine == null ||
          program.registrationDeadLine.toString().trim().isEmpty)
      ? 'TBA'
      : program.registrationDeadLine.toString();

  // Multi-color used for XP icon
  const LinearGradient rgbGradient = LinearGradient(
    colors: [Colors.redAccent, Colors.orangeAccent, Colors.redAccent],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  // Light two-tone gradient for premium reward outlines
  const LinearGradient lightBrandGradient = LinearGradient(
    colors: [Colors.blueAccent, Colors.lightGreenAccent],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProgramDetailPage(program: program),
        ),
      );
    },
    child: AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: _brandGradient, //
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.12),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      padding: const EdgeInsets.all(2.5), // Inner gap to create the border
      child: Container(
        decoration: BoxDecoration(
          // Premium Pastel Gradient Background
          gradient: const LinearGradient(
            colors: [
              Color(0xFFFFF3E8), // Distinct Soft Peach
              Colors.white, // Clean White center for text readability
              Color(0xFFFBE4EE), // Distinct Soft Pink
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.0, 0.4, 1.0],
          ),
          borderRadius: BorderRadius.circular(14.5),
        ),
        clipBehavior: Clip.hardEdge,
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // CARD LEFT: THUMBNAIL IMAGE
            Container(
              width: 85,
              height: 85,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                // Render local file if it exists, otherwise pull from Network URL
                child: program.imageFile != null
                    ? Image.file(
                        program.imageFile!,
                        fit: BoxFit.cover,
                        cacheWidth: 250, // Optimize memory
                      )
                    : Image.network(
                        program.imageUrl,
                        fit: BoxFit.cover,
                        cacheWidth: 250, // Optimize memory
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(
                              Icons.image,
                              color: Colors.grey,
                              size: 25,
                            ),
                      ),
              ),
            ),
            const SizedBox(width: 12),

            // CARD RIGHT: RESPONSIVE CONTENT BLOCK
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- Header Row: Title & Fee Container ---
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title masked with Brand Gradient
                      Expanded(
                        child: ShaderMask(
                          shaderCallback: (bounds) =>
                              _brandGradient.createShader(bounds),
                          child: Text(
                            program.title,
                            style: const TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 13,
                              color: Colors.white,
                              height: 1.2,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),

                      // Fee Tag (Only render if free or fee > 0)
                      if (program.isFree || program.fee > 0)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 1,
                          ),
                          decoration: BoxDecoration(
                            color: program.isFree
                                ? Colors.green.shade50
                                : Colors.amber.shade50,
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(
                              color: program.isFree
                                  ? Colors.green.shade300
                                  : Colors.amber.shade300,
                            ),
                          ),
                          child: Text(
                            program.isFree
                                ? 'FREE'
                                : '\$${program.fee.toStringAsFixed(0)}',
                            style: TextStyle(
                              color: program.isFree
                                  ? Colors.green.shade800
                                  : Colors.amber.shade900,
                              fontSize: 10,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                    ],
                  ),

                  // --- Speaker Data Row ---
                  if (program.speaker != null && program.speaker!.isNotEmpty)
                    Text(
                      '🧑‍💼 ${program.speaker}',
                      style: TextStyle(
                        fontSize: 8,
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),

                  const SizedBox(height: 2),

                  // --- Middle Row: Application Deadline & Live Spots ---
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Left: Bulletproof Deadline
                      Expanded(
                        child: Text(
                          'Application Deadline: $deadlineText',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 8),

                      // Right: Dynamic Spot Count Indicator
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.local_activity_outlined,
                            size: 12,
                            color: spotsColor,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            spotsText,
                            style: TextStyle(
                              color: spotsColor,
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 3),

                  // --- Bottom Row: Rewards & Host ---
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Left: Wrapping container for dynamic Rewards
                      Expanded(
                        child: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          spacing: 5,
                          runSpacing: 4,
                          children: [
                            if (program.offersCertificate)
                              buildPremiumIcon(
                                Icons.workspace_premium,
                                const Color(0xFFD4AF37),
                                lightBrandGradient,
                              ),
                            if (program.offersBadge)
                              buildPremiumIcon(
                                Icons.shield,
                                const Color(0xFF4169E1),
                                lightBrandGradient,
                              ),
                            if (program.offersMicroScholarships)
                              buildPremiumIcon(
                                Icons.school,
                                Colors.teal,
                                lightBrandGradient,
                              ),
                            if (program.offersLetterOfRecommendation)
                              buildPremiumIcon(
                                Icons.edit_document,
                                Colors.indigo,
                                lightBrandGradient,
                              ),
                            if (program.offersPhysicalSwags)
                              buildPremiumIcon(
                                Icons.redeem,
                                Colors.redAccent,
                                lightBrandGradient,
                              ),

                            // Custom XP Graphic Badge
                            if (program.offersXleratePoints)
                              Container(
                                width: 20,
                                height: 20,
                                padding: const EdgeInsets.all(1.5),
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: lightBrandGradient,
                                ),
                                child: Container(
                                  alignment: Alignment.center,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                  ),
                                  child: Center(
                                    child: ShaderMask(
                                      shaderCallback: (bounds) =>
                                          rgbGradient.createShader(bounds),
                                      child: const Text(
                                        'XP',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 8.5,
                                          fontWeight: FontWeight.w900,
                                          height: 1.0,

                                          shadows: [
                                            Shadow(
                                              color: Colors.white,
                                              offset: Offset(0.2, 0.2),
                                            ),
                                            Shadow(
                                              color: Colors.white,
                                              offset: Offset(-0.2, -0.2),
                                            ),
                                            Shadow(
                                              color: Colors.white,
                                              offset: Offset(0.2, -0.2),
                                            ),
                                            Shadow(
                                              color: Colors.white,
                                              offset: Offset(-0.2, 0.2),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),

                      // Right: Host Text (Custom Orange-to-Red Masked Gradient)
                      ShaderMask(
                        shaderCallback: (bounds) => const LinearGradient(
                          colors: [
                            Colors.orangeAccent, // Left color
                            Colors.redAccent, // Right color
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ).createShader(bounds),
                        child: Text(
                          program.host.toUpperCase(),
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w900,
                            color: Colors
                                .white, // Must remain white to absorb gradient mask
                            height: 1.0,
                            letterSpacing: 0.5,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
