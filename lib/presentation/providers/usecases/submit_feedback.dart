import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:xlerate/domain/usecases/submit_feedback/submit_feedback.dart';
import 'package:xlerate/presentation/providers/repositories/feedback_repository.dart/feedback_repository.dart';

part 'submit_feedback.g.dart';

@riverpod
SubmitFeedback submitFeedback(Ref ref) =>
    SubmitFeedback(feedbackRepository: ref.watch(feedbackRepositoryProvider));
