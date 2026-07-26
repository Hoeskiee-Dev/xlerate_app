// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_programs.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(getAllProgram)
final getAllProgramProvider = GetAllProgramProvider._();

final class GetAllProgramProvider
    extends $FunctionalProvider<GetAllPrograms, GetAllPrograms, GetAllPrograms>
    with $Provider<GetAllPrograms> {
  GetAllProgramProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getAllProgramProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getAllProgramHash();

  @$internal
  @override
  $ProviderElement<GetAllPrograms> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GetAllPrograms create(Ref ref) {
    return getAllProgram(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetAllPrograms value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetAllPrograms>(value),
    );
  }
}

String _$getAllProgramHash() => r'aea8ed6814ef7ccc323bb20dabca3d58005b693f';
