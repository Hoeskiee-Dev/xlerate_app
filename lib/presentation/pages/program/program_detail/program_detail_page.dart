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
import 'package:xlerate/presentation/providers/programs/apply_program_provider.dart';
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

  bool _checkIsEventEnded(String? endDateStr, String? startDateStr) {
    final targetDateStr = endDateStr ?? startDateStr;
    if (targetDateStr == null) return false;

    final eventDate = DateTime.tryParse(targetDateStr);
    if (eventDate == null) return false;

    return DateTime.now().isAfter(eventDate);
  }

  @override
  Widget build(BuildContext context) {
    // Watch asynchronous program detail provider using the programId
    final programDetailAsync = ref.watch(
      programDetailProvider(id: widget.programId),
    );

    // Watch current user state to access profile details and avatars
    final currentUser = ref.watch(userProvider);

    final userId = currentUser!.id;

    final applyState = ref.watch(applyProgramProvider);
    final isApplying = applyState.isLoading;

    final program = programDetailAsync.value;
    final bool hasApplied =
        program != null &&
        userId != null &&
        program.joinedUserIds.contains(userId);

    return Scaffold(
      body: programDetailAsync.when(
        data: (program) {
          // Localized display variable for program data updates
          var displayProgram = program;

          final bool isEnded = _checkIsEventEnded(
            displayProgram.endDate,
            displayProgram.startDate,
          );

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

              feedbackButton(
                isEventEnded: isEnded,
                onPressed: isEnded
                    ? () {
                        final formToLoad = displayProgram.feedbackForm;
                        if (formToLoad != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  FeedbackPage(form: formToLoad),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("No feedback form available."),
                            ),
                          );
                        }
                      }
                    : null,
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
                  backgroundColor: Colors.grey,
                  disabledBackgroundColor: Colors.grey,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
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
                      final currentProgram = programDetailAsync.asData!.value;
                      // 1. Await confirmation result from bottom sheet modal
                      final confirm = await showModalBottomSheet<bool>(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (context) => ApplyConfirmationSheet(
                          program: currentProgram,
                        ),
                      );

                      // 2. Trigger UI state update if application was confirmed successfully
                      if (confirm == true && context.mounted) {
                        final success = await ref
                            .read(applyProgramProvider.notifier)
                            .applyProgram(
                              program: currentProgram,
                              userId: userId,
                            );

                        if (context.mounted) {
                          if (success) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  "Successfully applied to program! 🎉",
                                ),
                                backgroundColor: Colors.green,
                              ),
                            );
                          } else {
                            final errorMsg = ref
                                .read(applyProgramProvider)
                                .error;
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  errorMsg?.toString() ?? "Failed to apply.",
                                ),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        }
                      }
                    }
                  : null,
            ),
    );
  }
}
