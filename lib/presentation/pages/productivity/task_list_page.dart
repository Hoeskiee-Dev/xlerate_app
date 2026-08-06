import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xlerate/domain/usecases/change_task_status/change_task_status_params.dart';
import 'package:xlerate/presentation/pages/productivity/create_task_page.dart';
import 'package:xlerate/presentation/pages/productivity/methods/task_chips.dart';
import 'package:xlerate/presentation/pages/productivity/methods/task_detail_dialog.dart';
import 'package:xlerate/presentation/pages/productivity/methods/task_header.dart';
import 'package:xlerate/presentation/pages/productivity/methods/task_search_bar.dart';
import 'package:xlerate/presentation/pages/productivity/methods/tasks_list.dart';
import 'package:xlerate/presentation/providers/tasks/remove_task_provider.dart';
import 'package:xlerate/presentation/providers/tasks/task_search_query.dart';
import 'package:xlerate/presentation/providers/tasks/tasks_list_provider.dart';
import 'package:xlerate/presentation/providers/tasks/update_task_status_provider.dart';

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
    final searchQuery = ref.watch(taskSearchQueryProvider);

    return Scaffold(
      body: ListView(
        children: [
          // * Page header
          taskHeader(context),

          // * Search bar
          taskSearchBar(
            controller: searchController,
            onChanged: (value) {
              ref.read(taskSearchQueryProvider.notifier).setQuery(value);
            },
            onClear: () {
              ref.read(taskSearchQueryProvider.notifier).clear();
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
            context: context,
            onTap: (task) {
              showTaskDetailDialog(context, task);
            },
            tasksAsync: tasksAsync,
            searchQuery: searchQuery,
            selectedPriority: selectedPriority,
            onStatusChanged: (task, isDone) {
              if (isDone == null) return;

              ref
                  .read(tasksListProvider.notifier)
                  .updateTaskStatusInState(
                    task.id,
                    isDone,
                  );

              ref
                  .read(updateTaskStatusProvider.notifier)
                  .updateTaskStatus(
                    params: ChangeTaskStatusParams(
                      id: task.id,
                      isDone: isDone,
                    ),
                  );
            },
            onRetry: () => ref.read(tasksListProvider.notifier).refresh(),
            onDelete: (task) {
              ref.read(tasksListProvider.notifier).removeTaskFromState(task.id);

              ref.read(removeTaskProvider.notifier).removeTask(params: task.id);

              ScaffoldMessenger.of(
                context,
              ).showSnackBar(
                const SnackBar(
                  content: Text("Task deleted!"),
                  duration: Duration(seconds: 1),
                ),
              );
            },
            onEdit: (task) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CreateTaskPage(task: task),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
