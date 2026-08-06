import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:xlerate/data/feedbacks/mock_feedback_repository.dart';
import 'package:xlerate/data/repositories/feedback_repository.dart';

part "feedback_repository.g.dart";

@riverpod
FeedbackRepository feedbackRepository(Ref ref) => MockFeedbackRepository();
