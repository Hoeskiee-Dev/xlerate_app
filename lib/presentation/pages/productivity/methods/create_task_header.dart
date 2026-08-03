import 'package:flutter/material.dart';

Widget createTaskHeader(BuildContext context, bool isUpdate) => Padding(
  padding: const EdgeInsets.all(16),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: CircleAvatar(
          backgroundColor: Colors.white,
          radius: 24,
          child: Icon(Icons.arrow_back),
        ),
      ),

      Text(
        isUpdate ? "Update Task" : "New Task",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
      ),

      const SizedBox(
        width: 48,
      ),
    ],
  ),
);
