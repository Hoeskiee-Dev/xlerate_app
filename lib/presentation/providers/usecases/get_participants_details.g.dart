// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_participants_details.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(getParticipantsDetails)
final getParticipantsDetailsProvider = GetParticipantsDetailsProvider._();

final class GetParticipantsDetailsProvider
    extends
        $FunctionalProvider<
          GetParticipantsDetails,
          GetParticipantsDetails,
          GetParticipantsDetails
        >
    with $Provider<GetParticipantsDetails> {
  GetParticipantsDetailsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getParticipantsDetailsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getParticipantsDetailsHash();

  @$internal
  @override
  $ProviderElement<GetParticipantsDetails> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GetParticipantsDetails create(Ref ref) {
    return getParticipantsDetails(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetParticipantsDetails value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetParticipantsDetails>(value),
    );
  }
}

String _$getParticipantsDetailsHash() =>
    r'f52033603cb71474edee546c5812738903b180a5';
