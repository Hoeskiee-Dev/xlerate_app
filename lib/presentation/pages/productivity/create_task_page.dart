import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xlerate/domain/entities/task.dart';
import 'package:xlerate/domain/entities/task_priority.dart';
import 'package:xlerate/domain/usecases/add_task/add_task_params.dart';
import 'package:xlerate/domain/usecases/update_task_details/update_task_details_params.dart';
import 'package:xlerate/presentation/pages/productivity/methods/create_task_header.dart';
import 'package:xlerate/presentation/pages/productivity/methods/date_range.dart';
import 'package:xlerate/presentation/pages/productivity/methods/description_text_field.dart';
import 'package:xlerate/presentation/pages/productivity/methods/priority_selection_chips.dart';
import 'package:xlerate/presentation/pages/productivity/methods/submit_task_button.dart';
import 'package:xlerate/presentation/pages/productivity/methods/text_task.dart';
import 'package:xlerate/presentation/pages/productivity/methods/title_text_field.dart';
import 'package:xlerate/presentation/providers/tasks/add_task_provider.dart';
import 'package:xlerate/presentation/providers/tasks/edit_task_provider.dart';
import 'package:xlerate/presentation/providers/tasks/tasks_list_provider.dart';
import 'package:xlerate/presentation/providers/user_provider.dart';

class CreateTaskPage extends ConsumerStatefulWidget {
  final Task? task;

  const CreateTaskPage({super.key, this.task});

  @override
  ConsumerState<CreateTaskPage> createState() => _CreateTaskPageState();
}

class _CreateTaskPageState extends ConsumerState<CreateTaskPage> {
  late var titleTextController = TextEditingController();
  late var descriptionTextController = TextEditingController();
  bool isAllDay = false;
  DateTime? startDate;
  DateTime? endDate;
  TaskPriority? selectedPriority = TaskPriority.medium;

  bool get isEditMode => widget.task != null;

  @override
  void initState() {
    super.initState();
    titleTextController = TextEditingController(text: widget.task?.title ?? '');
    descriptionTextController = TextEditingController(
      text: widget.task?.description ?? '',
    );

    if (isEditMode) {
      selectedPriority = widget.task!.priority;

      startDate = DateTime.fromMillisecondsSinceEpoch(
        widget.task!.startDate * 1000,
      );
      endDate = DateTime.fromMillisecondsSinceEpoch(
        widget.task!.endDate * 1000,
      );

      if (startDate!.year == endDate!.year &&
          startDate!.month == endDate!.month &&
          startDate!.day == endDate!.day) {
        isAllDay = true;
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    titleTextController.dispose();
    descriptionTextController.dispose();
  }

  Future<void> _handleSubmit() async {
    final title = titleTextController.text.trim();
    final description = descriptionTextController.text.trim();
    final userId = ref.read(userProvider)!.id;

    if (title.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Title cannot be empty")),
      );
      return;
    }

    if (startDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select a start date")),
      );
      return;
    }

    final DateTime normalizedStartDate = DateTime(
      startDate!.year,
      startDate!.month,
      startDate!.day,
      0,
      0,
      0,
    );

    final DateTime rawEndDate = (isAllDay || endDate == null)
        ? startDate!
        : endDate!;
    final DateTime normalizedEndDate = DateTime(
      rawEndDate.year,
      rawEndDate.month,
      rawEndDate.day,
      23,
      59,
      59,
    );

    final int startDateSec = normalizedStartDate.millisecondsSinceEpoch ~/ 1000;
    final int endDateSec = normalizedEndDate.millisecondsSinceEpoch ~/ 1000;

    String? errorMessage;

    if (isEditMode) {
      final updatedTask = widget.task!.copyWith(
        title: title,
        description: description,
        startDate: startDateSec,
        endDate: endDateSec,
        priority: selectedPriority ?? TaskPriority.medium,
      );

      errorMessage = await ref
          .read(editTaskProvider.notifier)
          .editTask(
            params: UpdateTaskDetailsParams(task: updatedTask),
            updatedTask: updatedTask,
          );
    } else {
      final newTask = Task(
        id: '', // * Automatic filled by MockAPI
        title: title,
        description: description,
        createdAt: 0,
        startDate: startDateSec,
        endDate: endDateSec,
        isDone: false,
        priority: selectedPriority ?? TaskPriority.medium,
        userId: userId,
      );

      errorMessage = await ref
          .read(createTaskProvider.notifier)
          .submitTask(params: AddTaskParams(task: newTask));
    }

    if (!mounted) return;

    if (errorMessage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            widget.task != null
                ? "Task updated successfully"
                : "Task created successfully!",
          ),
        ),
      );
      Navigator.pop(context);
      ref.read(tasksListProvider.notifier).refresh();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Failed to create task: $errorMessage"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final createTaskState = ref.watch(createTaskProvider);
    final editTaskState = ref.watch(editTaskProvider);

    final isLoading = isEditMode
        ? editTaskState.isLoading
        : createTaskState.isLoading;

    return Scaffold(
      body: ListView(
        children: [
          // * Create task header
          createTaskHeader(context, widget.task != null ? true : false),

          // * Text
          textTask(),

          // * Title text field
          titleTextField(
            controller: titleTextController,
          ),

          // * Date range
          dateRange(
            context: context,
            startDate: startDate,
            endDate: endDate,
            isAllDay: isAllDay,
            onStartDateSelected: (date) {
              setState(() {
                startDate = date;
                if (isAllDay) {
                  endDate = date;
                }
              });
            },
            onEndDateSelected: (date) {
              setState(() {
                endDate = date;
              });
            },
            onAllDayChanged: (value) {
              setState(() {
                isAllDay = value ?? false;
                if (isAllDay && startDate != null) {
                  endDate = startDate;
                }
              });
            },
          ),

          // * Priority selection chips
          prioritySelectionChips(
            selectedPriority: selectedPriority,
            onSelected: (priority) {
              setState(() {
                selectedPriority = priority;
              });
            },
          ),

          // * Description text field
          descriptionTextField(controller: descriptionTextController),
        ],
      ),
      bottomNavigationBar: submitTaskButton(
        isLoading: isLoading,
        onPressed: _handleSubmit,
      ),
    );
  }
}
