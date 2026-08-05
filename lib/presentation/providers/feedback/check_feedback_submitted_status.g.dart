// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_feedback_submitted_status.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CheckFeedbackSubmittedStatus)
final checkFeedbackSubmittedStatusProvider =
    CheckFeedbackSubmittedStatusProvider._();

final class CheckFeedbackSubmittedStatusProvider
    extends $AsyncNotifierProvider<CheckFeedbackSubmittedStatus, bool?> {
  CheckFeedbackSubmittedStatusProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'checkFeedbackSubmittedStatusProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$checkFeedbackSubmittedStatusHash();

  @$internal
  @override
  CheckFeedbackSubmittedStatus create() => CheckFeedbackSubmittedStatus();
}

String _$checkFeedbackSubmittedStatusHash() =>
    r'539acd8a3367e7be6f7690047243fadb6d3860ca';

abstract class _$CheckFeedbackSubmittedStatus extends $AsyncNotifier<bool?> {
  FutureOr<bool?> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<bool?>, bool?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<bool?>, bool?>,
              AsyncValue<bool?>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
