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
import 'package:xlerate/presentation/pages/program/program_detail/widgets/apply_confirmation_sheet.dart';
import 'package:xlerate/presentation/providers/user_provider.dart';

/// Screen responsible for displaying detailed program information, schedule details,
/// attendee lists, feedback action hooks, and program registration workflows.
class ProgramDetailPage extends ConsumerStatefulWidget {
  // Unique identifier for fetching specific program data
  final String programId;
  const ProgramDetailPage({super.key, required this.programId});

  @override
  ConsumerState<ProgramDetailPage> createState() => _ProgramDetailPageState();
}

class _ProgramDetailPageState extends ConsumerState<ProgramDetailPage> {
  // Local state to track whether the user has successfully registered/applied for the program
  bool hasApplied = false;

  @override
  Widget build(BuildContext context) {
    // Watch asynchronous program detail provider using the programId
    final programDetailAsync = ref.watch(
      programDetailProvider(id: widget.programId),
    );

    // Watch current user state to access profile details and avatars
    final currentUser = ref.watch(userProvider);

    return Scaffold(
      body: programDetailAsync.when(
        data: (program) {
          // Localized display variable for program data updates
          var displayProgram = program;

          if (hasApplied) {}

          return ListView(
            children: [
              // --- EVENT HEADER BANNER ---
              eventHeader(context, displayProgram),

              // --- EVENT TITLE AND METADATA ---
              eventTitle(displayProgram),

              // --- ATTENDEES THUMBNAILS LIST ---
              attendies(context, displayProgram),

              // --- PROGRAM DESCRIPTION SECTION ---
              DescriptionSection(program: displayProgram),

              verticalSpaces(16),

              // --- FEEDBACK BUTTON ACTION ---
              feedbackButton(
                isEventEnded: false,
                onPressed: () {
                  final formToLoad = displayProgram.feedbackForm;
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
              verticalSpaces(
                100,
              ), // Bottom padding buffer to clear floating nav bars
            ],
          );
        },

        // Loading state indicator
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),

        // Error handling view with friendly messaging
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

      // --- BOTTOM NAVIGATION BAR: DYNAMIC APPLY / APPLIED STATE ---
      bottomNavigationBar: hasApplied
          ? Container(
              padding: const EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed: null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  disabledBackgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Applied",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          : applyButton(
              isLoading: programDetailAsync.isLoading,
              onPressed: programDetailAsync.hasValue
                  ? () async {
                      // 1. Await confirmation result from bottom sheet modal
                      final result = await showModalBottomSheet<bool>(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (context) => ApplyConfirmationSheet(
                          program: programDetailAsync.asData!.value!,
                        ),
                      );

                      // 2. Trigger UI state update if application was confirmed successfully
                      if (result == true) {
                        setState(() {
                          hasApplied = true;
                        });
                      }
                    }
                  : null,
            ),
    );
  }
}
