import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xlerate/presentation/pages/productivity/methods/task_chips.dart';
import 'package:xlerate/presentation/pages/productivity/methods/task_header.dart';
import 'package:xlerate/presentation/pages/productivity/methods/task_search_bar.dart';
import 'package:xlerate/presentation/pages/productivity/methods/tasks_list.dart';
import 'package:xlerate/presentation/providers/tasks/remove_task_provider.dart';
import 'package:xlerate/presentation/providers/tasks/tasks_list_provider.dart';
import 'package:xlerate/presentation/providers/usecases/delete_task.dart';

class TaskListPage extends ConsumerStatefulWidget {
  const TaskListPage({super.key});

  @override
  ConsumerState<TaskListPage> createState() => _TaskListPageState();
}

class _TaskListPageState extends ConsumerState<TaskListPage> {
  final searchController = TextEditingController();
  String selectedPriority = "";

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tasksAsync = ref.watch(tasksListProvider);

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
            tasksAsync: tasksAsync,
            selectedPriority: selectedPriority,
            onStatusChanged: (task, isDone) {},
            onRetry: () => ref.read(tasksListProvider.notifier).refresh(),
            onDismissed: (task) {
              ref.read(removeTaskProvider.notifier).removeTask(params: task.id);
            },
          ),
        ],
      ),
    );
  }
}
