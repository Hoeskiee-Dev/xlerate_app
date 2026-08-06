// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_task_details.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(getTaskDetails)
final getTaskDetailsProvider = GetTaskDetailsProvider._();

final class GetTaskDetailsProvider
    extends $FunctionalProvider<GetTaskDetails, GetTaskDetails, GetTaskDetails>
    with $Provider<GetTaskDetails> {
  GetTaskDetailsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getTaskDetailsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getTaskDetailsHash();

  @$internal
  @override
  $ProviderElement<GetTaskDetails> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GetTaskDetails create(Ref ref) {
    return getTaskDetails(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetTaskDetails value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetTaskDetails>(value),
    );
  }
}

String _$getTaskDetailsHash() => r'0fd86d1378eb2130935762527650140ce9e68f35';
