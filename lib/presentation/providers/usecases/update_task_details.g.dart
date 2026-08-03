// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_task_details.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(updateTaskDetails)
final updateTaskDetailsProvider = UpdateTaskDetailsProvider._();

final class UpdateTaskDetailsProvider
    extends
        $FunctionalProvider<
          UpdateTaskDetails,
          UpdateTaskDetails,
          UpdateTaskDetails
        >
    with $Provider<UpdateTaskDetails> {
  UpdateTaskDetailsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'updateTaskDetailsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$updateTaskDetailsHash();

  @$internal
  @override
  $ProviderElement<UpdateTaskDetails> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  UpdateTaskDetails create(Ref ref) {
    return updateTaskDetails(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UpdateTaskDetails value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UpdateTaskDetails>(value),
    );
  }
}

String _$updateTaskDetailsHash() => r'aa44d2bb6ac0a780b9899b1ff86a94f2a8584690';
