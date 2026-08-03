import 'package:flutter/material.dart';
import 'package:xlerate/presentation/misc/methods.dart';

Widget descriptionTextField({required TextEditingController controller}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Descriptions",
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 14,
          ),
        ),
        verticalSpaces(4),
        TextField(
          controller: controller,
          maxLines: 4,
          minLines: 3,
          keyboardType: TextInputType.multiline,
          decoration: InputDecoration(
            hintText:
                "Need to create app briefing like wireframe, app purpose, etc.",
            hintStyle: TextStyle(color: Colors.grey.shade400),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),

            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                color: Colors.grey.shade400,
                width: 1.0,
              ),
            ),

            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(
                color: Colors.black,
                width: 2.0,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
