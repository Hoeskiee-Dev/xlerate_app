import 'package:flutter/material.dart';
import 'package:xlerate/domain/entities/task.dart';
import 'package:xlerate/domain/entities/task_priority.dart';
import 'package:xlerate/presentation/pages/productivity/methods/task_chips.dart';
import 'package:xlerate/presentation/pages/productivity/methods/task_header.dart';
import 'package:xlerate/presentation/pages/productivity/methods/task_search_bar.dart';
import 'package:xlerate/presentation/pages/productivity/methods/tasks_list.dart';

class TaskListPage extends StatefulWidget {
  const TaskListPage({super.key});

  @override
  State<TaskListPage> createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
  final searchController = TextEditingController();
  String selectedPriority = "";

  final List<Task> dummyTasks = [
    Task(
      id: "1",
      title: "Create app briefing",
      description: "App briefing for project",
      createdAt: 1785597434,
      startDate: 1785597434,
      endDate: 1785597434,
      isDone: false,
      priority: TaskPriority.low,
      userId: "1,",
    ),
    Task(
      id: "2",
      title: "Design task screen UI",
      description: "UI Mockup for Task List",
      createdAt: 1785597434,
      startDate: 1785597434,
      endDate: 1785597434,
      isDone: true,
      priority: TaskPriority.high,
      userId: "2,",
    ),
  ];

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

          // * Tasks list
          ...tasksList(
            tasks: dummyTasks,
            onStatusChanged: (task, isDone) {},
          ),
        ],
      ),
    );
  }
}
