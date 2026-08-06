import 'package:flutter/material.dart';
import 'package:xlerate/presentation/misc/methods.dart';
import 'package:xlerate/domain/entities/program.dart';
import 'package:url_launcher/url_launcher.dart'; // 1. Added this import

Widget detailsContent(Program program) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "Program Details",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
      verticalSpaces(8),

      Row(
        children: [
          Row(
            children: [
              Icon(
                Icons.date_range,
              ),
              horizontalSpaces(8),
              Text(
                (program.endDate != null && program.endDate!.isNotEmpty)
                    ? "${program.startDate} - ${program.endDate}"
                    : program.startDate,
              ),
            ],
          ),

          horizontalSpaces(24),
          Row(
            children: [
              Icon(
                Icons.watch_later,
              ),
              horizontalSpaces(8),
              Text(program.time),
            ],
          ),
        ],
      ),

      verticalSpaces(8),

      Row(
        children: [
          Icon(
            Icons.location_on,
          ),
          horizontalSpaces(8),
          Text(program.location),
        ],
      ),

      verticalSpaces(8),

      Row(
        children: [
          Icon(
            Icons.attach_money,
          ),
          horizontalSpaces(8),
          Text(
            program.isFree ? "Free" : "\$${program.fee.toInt()}",
          ),
        ],
      ),

      verticalSpaces(16),

      Text(
        "Program Descriptions",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
      verticalSpaces(8),
      Text(
        program.description,
        style: const TextStyle(color: Colors.black87, height: 1.5),
      ),

      // ---  NEW EVENT URL SECTION ---
      if (program.url != null && program.url!.isNotEmpty) ...[
        verticalSpaces(16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.link, color: Colors.blueAccent, size: 20),
            horizontalSpaces(8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'For more info, please visit:',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  verticalSpaces(4),
                  GestureDetector(
                    onTap: () async {
                      String urlString = program.url!.trim();

                      if (!urlString.startsWith('http://') &&
                          !urlString.startsWith('https://')) {
                        urlString = 'https://$urlString';
                      }

                      final Uri url = Uri.parse(urlString);

                      try {
                        if (await canLaunchUrl(url)) {
                          await launchUrl(
                            url,
                            mode: LaunchMode.externalApplication,
                          );
                        } else {
                          debugPrint('Could not launch $url');
                        }
                      } catch (e) {
                        debugPrint('Error launching url: $e');
                      }
                    },
                    child: Text(
                      program.url!,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.blueAccent,
                        decoration: TextDecoration.underline,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    ],
  );
}
