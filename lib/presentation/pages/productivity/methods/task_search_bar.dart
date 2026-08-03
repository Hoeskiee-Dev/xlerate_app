import 'package:flutter/material.dart';

Padding taskSearchBar({
  required TextEditingController controller,
  Function(String)? onSubmitted,
}) => Padding(
  padding: const EdgeInsets.symmetric(horizontal: 16),
  child: Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: Colors.grey.shade400),
    ),
    child: TextField(
      controller: controller,
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
        border: InputBorder.none,
        focusColor: Colors.red,
        prefixIcon: Icon(Icons.search),
        hintText: "Search your task here",
        hintStyle: TextStyle(color: Colors.grey.shade500),
      ),
      textInputAction: TextInputAction.search,
      onSubmitted: onSubmitted,
    ),
  ),
);
