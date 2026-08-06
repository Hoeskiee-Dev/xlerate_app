// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_feedback_submitted.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(checkFeedbackSubmitted)
final checkFeedbackSubmittedProvider = CheckFeedbackSubmittedProvider._();

final class CheckFeedbackSubmittedProvider
    extends
        $FunctionalProvider<
          CheckFeedbackSubmitted,
          CheckFeedbackSubmitted,
          CheckFeedbackSubmitted
        >
    with $Provider<CheckFeedbackSubmitted> {
  CheckFeedbackSubmittedProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'checkFeedbackSubmittedProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$checkFeedbackSubmittedHash();

  @$internal
  @override
  $ProviderElement<CheckFeedbackSubmitted> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CheckFeedbackSubmitted create(Ref ref) {
    return checkFeedbackSubmitted(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CheckFeedbackSubmitted value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CheckFeedbackSubmitted>(value),
    );
  }
}

String _$checkFeedbackSubmittedHash() =>
    r'69ea298d368df066dc9d01fdfd4b969cb50c9703';
