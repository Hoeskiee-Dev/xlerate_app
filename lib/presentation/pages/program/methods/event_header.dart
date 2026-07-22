import 'package:flutter/material.dart';
import 'package:xlerate/presentation/misc/methods.dart';
import 'package:xlerate/data/program_data.dart';

Widget eventHeader(BuildContext context, Program program) => Stack(
  children: [
    // * Event image
    Image.network(
      program.imageUrl,
      width: double.infinity,
      height: 250,
      fit: BoxFit.cover,
    ),

    // * Navigation button
    Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: CircleAvatar(
              backgroundColor: Colors.grey.shade400.withOpacity(0.75),
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 24,
              ),
            ),
          ),
          Spacer(),
          GestureDetector(
            onTap: () {
              // ! TODO : Implement add to favorite feature
            },
            child: CircleAvatar(
              backgroundColor: Colors.grey.shade400.withOpacity(0.75),
              child: Icon(
                Icons.star_border_outlined,
                color: Colors.white,
                size: 24,
              ),
            ),
          ),

          horizontalSpaces(16),

          GestureDetector(
            onTap: () {
              // ! TODO : Implement share event feature
            },
            child: CircleAvatar(
              backgroundColor: Colors.grey.shade400.withOpacity(0.75),
              child: Icon(
                Icons.share,
                color: Colors.white,
                size: 24,
              ),
            ),
          ),
        ],
      ),
    ),

    // * Event tags
    Positioned(
      bottom: 12,
      left: 12,
      child: Container(
        padding: const EdgeInsets.fromLTRB(12, 6, 12, 6),
        alignment: Alignment.bottomLeft,
        decoration: BoxDecoration(
          color: Colors.grey.withAlpha(204),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              program.host,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text.rich(
              TextSpan(
                children: [
                  const TextSpan(
                    text: " | ",
                    style: TextStyle(
                      color: Color.fromARGB(
                        255,
                        199,
                        22,
                        161,
                      ),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: program.speaker,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  ],
);
