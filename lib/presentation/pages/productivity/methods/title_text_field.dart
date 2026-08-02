import 'package:flutter/material.dart';

Widget titleTextField({required TextEditingController controller}) => Padding(
  padding: const EdgeInsetsGeometry.all(16),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "Task Title",
        style: TextStyle(
          color: Colors.grey.shade600,
        ),
      ),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(16),
        ),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "Enter your task title",
          ),
        ),
      ),
    ],
  ),
);
