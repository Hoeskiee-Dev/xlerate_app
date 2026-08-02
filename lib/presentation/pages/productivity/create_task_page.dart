import 'package:flutter/material.dart';
import 'package:xlerate/presentation/pages/productivity/methods/create_task_header.dart';
import 'package:xlerate/presentation/pages/productivity/methods/date_range.dart';
import 'package:xlerate/presentation/pages/productivity/methods/text_task.dart';
import 'package:xlerate/presentation/pages/productivity/methods/title_text_field.dart';

class CreateTaskPage extends StatefulWidget {
  const CreateTaskPage({super.key});

  @override
  State<CreateTaskPage> createState() => _CreateTaskPageState();
}

class _CreateTaskPageState extends State<CreateTaskPage> {
  final titleTextController = TextEditingController();
  bool isAllDay = false;
  DateTime? startDate;
  DateTime? endDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          // * Create task header
          createTaskHeader(context),

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

          // * Priority chips

          // * Description text field
        ],
      ),
    );
  }
}
