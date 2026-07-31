import 'package:flutter/material.dart';
import 'package:xlerate/presentation/pages/productivity/methods/task_card.dart';
import 'package:xlerate/presentation/pages/productivity/methods/task_chips.dart';
import 'package:xlerate/presentation/pages/productivity/methods/task_header.dart';
import 'package:xlerate/presentation/pages/productivity/methods/task_search_bar.dart';

class TaskListPage extends StatefulWidget {
  const TaskListPage({super.key});

  @override
  State<TaskListPage> createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
  final searchController = TextEditingController();
  String selectedPriority = "";

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          // * Page header
          taskHeader(context),

          // * Search bar
          taskSearchBar(
            controller: searchController,
            onSubmitted: (value) {
              // ! TODO : Implement notifier for search query
            },
          ),

          // * Task Chips
          taskChips(
            selectedPriority: selectedPriority,
            onSelected: (priority) {
              setState(() {
                if (selectedPriority == priority) {
                  selectedPriority = '';
                } else {
                  selectedPriority = priority;
                }
              });
            },
          ),
          // * Text
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              "Get consistent. Complete your task.",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // // * Tasks list
          // ...tasksList(),
          taskCard(),
          taskCard(),
          taskCard(),
        ],
      ),
    );
  }
}
