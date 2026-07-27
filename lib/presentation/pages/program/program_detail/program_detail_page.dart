import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

        error: (error, stackTrace) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Failed to load program: $error'),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () =>
                    ref.refresh(programDetailProvider(id: programId)),
                child: const Text('Retry'),
              ),
            ],
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
