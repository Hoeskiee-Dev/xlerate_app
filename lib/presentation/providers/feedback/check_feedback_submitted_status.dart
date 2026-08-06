import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:xlerate/core/result.dart';
import 'package:xlerate/domain/usecases/check_feedback_submitted/check_feedback_submitted.dart';
import 'package:xlerate/presentation/providers/usecases/check_feedback_submitted.dart';

part 'check_feedback_submitted_status.g.dart';

@riverpod
class CheckFeedbackSubmittedStatus extends _$CheckFeedbackSubmittedStatus {
  @override
  FutureOr<bool?> build() {
    return null;
  }

  Future<bool> checkFeedbackStatus({
    required CheckFeedbackSubmittedParams params,
  }) async {
    state = const AsyncLoading();

    final checkUsecase = ref.read(checkFeedbackSubmittedProvider);
    final result = await checkUsecase(params);

    switch (result) {
      case Success(value: final isSubmitted):
        if (!ref.mounted) return isSubmitted;
        state = AsyncData(isSubmitted);
        return isSubmitted;

      case Failed(:final message):
        state = AsyncError(message, StackTrace.current);
        return false;
    }
  }
}
