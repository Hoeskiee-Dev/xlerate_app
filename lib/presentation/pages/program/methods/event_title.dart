import 'package:flutter/widgets.dart';
import 'package:xlerate/presentation/pages/program/methods/event_tags.dart';
import 'package:xlerate/data/program_data.dart';

/* final List<String> eventLabel = [
  "Tech",
  "Modern",
  "Architecture",
  "Architecture",
  "Architecture",
  "Architecture",
]; */

Widget eventTitle(Program program) => Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    // * Event title
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Text(
        program.title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
      ),
    ),

    // * Event tags
    SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.only(left: 16),
        child: Row(
          children: [
            ...program.tag
                .split(',')
                .map(
                  (tagName) => Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: eventTags(tagName.trim()),
                  ),
                ),
          ],
        ),
      ),
    ),
  ],
);
