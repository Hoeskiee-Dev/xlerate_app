import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xlerate/core/error_helper.dart';
import 'package:xlerate/presentation/misc/methods.dart';
import 'package:xlerate/presentation/pages/program/program_detail/methods/apply_button.dart';
import 'package:xlerate/presentation/pages/program/program_detail/methods/attendies.dart';
import 'package:xlerate/presentation/pages/program/program_detail/methods/event_header.dart';
import 'package:xlerate/presentation/pages/program/program_detail/methods/event_title.dart';
import 'package:xlerate/presentation/pages/program/program_detail/methods/feedback_button.dart';
import 'package:xlerate/presentation/pages/program/program_detail/widgets/description_section.dart';
import 'package:xlerate/presentation/pages/feedback/feedback_page.dart';
import 'package:xlerate/presentation/providers/programs/program_detail_provider.dart';

class ProgramDetailPage extends ConsumerWidget {
  final String programId;
  const ProgramDetailPage({super.key, required this.programId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final programDetailAsync = ref.watch(programDetailProvider(id: programId));

    return Scaffold(
      body: programDetailAsync.when(
        data: (program) {
          return ListView(
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
                      const SnackBar(
                        content: Text("No feedback form available."),
                      ),
                    );
                  }
                },
              ),
              verticalSpaces(100),
            ],
          );
        },

        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),

        error: (error, stack) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.wifi_off_rounded,
                  color: Colors.grey,
                  size: 40,
                ),
                const SizedBox(height: 8),
                Text(
                  getReadableErrorMessage(error),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.red.shade400,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: applyButton(
        isLoading: programDetailAsync.isLoading,
        onPressed: () {
          // ! TODO : Confirmation screen feature
        },
      ),
    );
  }
}
