import 'package:flutter/material.dart';

Widget taskCard() => Padding(
  padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
  child: Container(
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          blurRadius: 1,
          offset: Offset(2, 4),
          color: Colors.grey.shade200,
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // * Checkbox & task name
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Checkbox(
              value: true,
              onChanged: (isCompleted) {},
            ),
            Text(
              "Create app briefing",
              style: TextStyle(fontSize: 17),
            ),
          ],
        ),

        // * End date
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
              child: Text(
                "11.59 PM, 13 July 2026",
                style: TextStyle(fontSize: 15),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                "High",
              ),
            ),
          ],
        ),
      ],
    ),
  ),
);
