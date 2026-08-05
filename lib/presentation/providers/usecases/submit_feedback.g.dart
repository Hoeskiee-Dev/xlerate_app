// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'submit_feedback.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(submitFeedback)
final submitFeedbackProvider = SubmitFeedbackProvider._();

final class SubmitFeedbackProvider
    extends $FunctionalProvider<SubmitFeedback, SubmitFeedback, SubmitFeedback>
    with $Provider<SubmitFeedback> {
  SubmitFeedbackProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'submitFeedbackProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$submitFeedbackHash();

  @$internal
  @override
  $ProviderElement<SubmitFeedback> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SubmitFeedback create(Ref ref) {
    return submitFeedback(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SubmitFeedback value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SubmitFeedback>(value),
    );
  }
}

String _$submitFeedbackHash() => r'0d92120b87e8c4d76f8c22ace2e1baacc473966c';
