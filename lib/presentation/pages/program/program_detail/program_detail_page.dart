import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xlerate/core/error_helper.dart';
import 'package:xlerate/domain/usecases/check_feedback_submitted/check_feedback_submitted.dart';
import 'package:xlerate/presentation/misc/methods.dart';
import 'package:xlerate/presentation/pages/program/program_detail/methods/apply_button.dart';
import 'package:xlerate/presentation/pages/program/program_detail/methods/attendies.dart';
import 'package:xlerate/presentation/pages/program/program_detail/methods/event_header.dart';
import 'package:xlerate/presentation/pages/program/program_detail/methods/event_title.dart';
import 'package:xlerate/presentation/pages/program/program_detail/methods/feedback_button.dart';
import 'package:xlerate/presentation/pages/program/program_detail/widgets/description_section.dart';
import 'package:xlerate/presentation/pages/feedback/feedback_page.dart';
import 'package:xlerate/presentation/providers/feedback/check_feedback_submitted_status.dart';
import 'package:xlerate/presentation/providers/programs/apply_program_provider.dart';
import 'package:xlerate/presentation/providers/programs/program_detail_provider.dart';
import 'package:xlerate/presentation/pages/program/program_detail/widgets/apply_confirmation_sheet.dart';
import 'package:xlerate/presentation/providers/programs/programs_list_provider.dart';
import 'package:xlerate/presentation/providers/user_provider.dart';

class ProgramDetailPage extends ConsumerStatefulWidget {
  final String programId;
  const ProgramDetailPage({super.key, required this.programId});

  @override
  ConsumerState<ProgramDetailPage> createState() => _ProgramDetailPageState();
}

class _ProgramDetailPageState extends ConsumerState<ProgramDetailPage> {
  bool hasApplied = false;
  bool hasSubmittedFeedback = false;

  bool _checkIsEventEnded(String? endDateStr, String? startDateStr) {
    final targetDateStr = endDateStr ?? startDateStr;
    if (targetDateStr == null) return false;

    final eventDate = DateTime.tryParse(targetDateStr);
    if (eventDate == null) return false;

    return DateTime.now().isAfter(eventDate);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkFeedbackStatus();
    });
  }

  void _checkFeedbackStatus() {
    final userId = ref.read(userProvider)?.id;
    if (userId != null) {
      ref
          .read(checkFeedbackSubmittedStatusProvider.notifier)
          .checkFeedbackStatus(
            params: CheckFeedbackSubmittedParams(
              programId: widget.programId,
              userId: userId,
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final programDetailAsync = ref.watch(
      programDetailProvider(id: widget.programId),
    );

    final currentUser = ref.watch(userProvider);

    final userId = currentUser?.id;

    final checkFeedbackState = ref.watch(checkFeedbackSubmittedStatusProvider);
    final bool isSubmittedFromApi = checkFeedbackState.value ?? false;

    final bool isFeedbackSubmitted = hasSubmittedFeedback || isSubmittedFromApi;

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
          var displayProgram = program;

          final bool isEnded = _checkIsEventEnded(
            displayProgram.endDate,
            displayProgram.startDate,
          );

          if (hasApplied) {}

          return ListView(
            children: [
              eventHeader(context, displayProgram),

              eventTitle(displayProgram),

              attendies(context, displayProgram),

              DescriptionSection(program: displayProgram),

              verticalSpaces(16),

              feedbackButton(
                isEventEnded: isEnded,
                isSubmitted: isFeedbackSubmitted,
                onPressed: (isEnded && !isFeedbackSubmitted)
                    ? () async {
                        final formToLoad = displayProgram.feedbackForm;
                        if (formToLoad != null) {
                          final result = await Navigator.push<bool>(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FeedbackPage(
                                form: formToLoad,
                                programId: widget.programId,
                              ),
                            ),
                          );

                          if (result == true && mounted) {
                            setState(() {
                              hasSubmittedFeedback = true;
                            });

                            ref.invalidate(
                              checkFeedbackSubmittedStatusProvider,
                            );

                            Future.microtask(() {
                              _checkFeedbackStatus();
                            });
                          }
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
              ),
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
                      final confirm = await showModalBottomSheet<bool>(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (context) => ApplyConfirmationSheet(
                          program: currentProgram,
                        ),
                      );

                      if (confirm == true && context.mounted) {
                        final success = await ref
                            .read(applyProgramProvider.notifier)
                            .applyProgram(
                              program: currentProgram,
                              userId: userId!,
                            );

                        if (context.mounted) {
                          if (success) {
                            ref.read(programsListProvider.notifier).refresh();

                            ref.invalidate(
                              programDetailProvider(id: widget.programId),
                            );

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
