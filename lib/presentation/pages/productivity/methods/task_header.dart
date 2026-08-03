import 'package:flutter/material.dart';
import 'package:xlerate/presentation/pages/productivity/create_task_page.dart';

Widget taskHeader(BuildContext context) => Padding(
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

      const Text(
        "Task List",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
      ),

      GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateTaskPage()),
          );
        },
        child: CircleAvatar(
          backgroundColor: Colors.white,
          radius: 24,
          child: Icon(Icons.add),
        ),
      ),
    ],
  ),
);
