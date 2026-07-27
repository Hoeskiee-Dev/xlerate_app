// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'program_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(programRepository)
final programRepositoryProvider = ProgramRepositoryProvider._();

final class ProgramRepositoryProvider
    extends
        $FunctionalProvider<
          ProgramsRepository,
          ProgramsRepository,
          ProgramsRepository
        >
    with $Provider<ProgramsRepository> {
  ProgramRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'programRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$programRepositoryHash();

  @$internal
  @override
  $ProviderElement<ProgramsRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ProgramsRepository create(Ref ref) {
    return programRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ProgramsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ProgramsRepository>(value),
    );
  }
}

String _$programRepositoryHash() => r'3bbecc9dfc02ad15989e777d6de41aa2119be25b';
