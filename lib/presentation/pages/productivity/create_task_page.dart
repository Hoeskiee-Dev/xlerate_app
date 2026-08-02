import 'package:flutter/material.dart';
import 'package:xlerate/presentation/pages/productivity/methods/create_task_header.dart';

class CreateTaskPage extends StatelessWidget {
  const CreateTaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          // * Create task header
          createTaskHeader(context),

          // * Text

          // * Title text field

          // * Date range

          // * Priority chips

          // * Description text field
        ],
      ),
    );
  }
}
