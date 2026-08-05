import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:xlerate/domain/usecases/check_feedback_submitted/check_feedback_submitted.dart';
import 'package:xlerate/presentation/providers/repositories/feedback_repository.dart/feedback_repository.dart';

part 'check_feedback_submitted.g.dart';

@riverpod
CheckFeedbackSubmitted checkFeedbackSubmitted(Ref ref) =>
    CheckFeedbackSubmitted(
      feedbackRepository: ref.watch(feedbackRepositoryProvider),
    );
