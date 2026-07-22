import 'package:flutter/material.dart';
import 'package:xlerate/presentation/misc/methods.dart';
import 'package:xlerate/data/program_data.dart';

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
    ],
  );
}
