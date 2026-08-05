// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_feedback_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AddFeedback)
final addFeedbackProvider = AddFeedbackProvider._();

final class AddFeedbackProvider
    extends $AsyncNotifierProvider<AddFeedback, void> {
  AddFeedbackProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'addFeedbackProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$addFeedbackHash();

  @$internal
  @override
  AddFeedback create() => AddFeedback();
}

String _$addFeedbackHash() => r'eceba336b285877ca5a7bf74ac217cc33fcf903d';

abstract class _$AddFeedback extends $AsyncNotifier<void> {
  FutureOr<void> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<void>, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, void>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
