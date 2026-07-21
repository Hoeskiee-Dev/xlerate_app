import 'package:flutter/material.dart';
import 'package:xlerate/presentation/misc/methods.dart';
import 'package:xlerate/presentation/pages/program/methods/apply_button.dart';
import 'package:xlerate/presentation/pages/program/methods/attendies.dart';
import 'package:xlerate/presentation/pages/program/methods/event_header.dart';
import 'package:xlerate/presentation/pages/program/methods/event_title.dart';
import 'package:xlerate/presentation/pages/program/methods/feedback_button.dart';
import 'package:xlerate/presentation/pages/program/widgets/description_section.dart';
import 'package:xlerate/presentation/pages/feedback_page.dart';
import 'package:xlerate/data/program_data.dart';

class ProgramDetailPage extends StatelessWidget {
  final Program program;
  const ProgramDetailPage({super.key, required this.program});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          eventHeader(context, program),
          eventTitle(program),
          attendies(program),
          DescriptionSection(program: program),

          verticalSpaces(16),

          // * Feedback Button
          feedbackButton(
            isEventEnded: false,
            onPressed: () {
              // Grabs the specific mock form attached to the program
              final formToLoad = program.feedbackForm;
              if (formToLoad != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FeedbackPage(form: formToLoad),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("No feedback form available.")),
                );
              }
            },
          ),
          verticalSpaces(100),
        ],
      ),
      bottomNavigationBar: applyButton(),
    );
  }
}
