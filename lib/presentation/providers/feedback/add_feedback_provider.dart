import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:xlerate/core/result.dart';
import 'package:xlerate/domain/entities/feedback_submission.dart';
import 'package:xlerate/presentation/providers/usecases/submit_feedback.dart';

part 'add_feedback_provider.g.dart';

@riverpod
class AddFeedback extends _$AddFeedback {
  @override
  FutureOr<void> build() {
    return null;
  }

  Future<bool> submitFeedback(FeedbackSubmission submission) async {
    state = const AsyncLoading();

    final submitFeedbackUsecase = ref.read(submitFeedbackProvider);
    final result = await submitFeedbackUsecase(submission);

    switch (result) {
      case Success():
        if (!ref.mounted) return true;
        state = const AsyncData(null);

        return true;

      case Failed(:final message):
        state = AsyncError(message, StackTrace.current);
        return false;
    }
  }
}
