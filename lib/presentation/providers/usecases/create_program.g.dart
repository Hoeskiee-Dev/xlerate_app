// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_program.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(createProgram)
final createProgramProvider = CreateProgramProvider._();

final class CreateProgramProvider
    extends $FunctionalProvider<CreateProgram, CreateProgram, CreateProgram>
    with $Provider<CreateProgram> {
  CreateProgramProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'createProgramProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$createProgramHash();

  @$internal
  @override
  $ProviderElement<CreateProgram> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  CreateProgram create(Ref ref) {
    return createProgram(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CreateProgram value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CreateProgram>(value),
    );
  }
}

String _$createProgramHash() => r'f719a312a145ecff8a06b6d09178eb362f6b97f1';
