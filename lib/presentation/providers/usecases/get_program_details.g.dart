// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_program_details.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(getProgramDetails)
final getProgramDetailsProvider = GetProgramDetailsProvider._();

final class GetProgramDetailsProvider
    extends
        $FunctionalProvider<
          GetProgramDetails,
          GetProgramDetails,
          GetProgramDetails
        >
    with $Provider<GetProgramDetails> {
  GetProgramDetailsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getProgramDetailsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getProgramDetailsHash();

  @$internal
  @override
  $ProviderElement<GetProgramDetails> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GetProgramDetails create(Ref ref) {
    return getProgramDetails(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetProgramDetails value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetProgramDetails>(value),
    );
  }
}

String _$getProgramDetailsHash() => r'6838d757a33a65c2640acf57e26bbfbcacf8c2d6';
