// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_program.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(editProgram)
final editProgramProvider = EditProgramProvider._();

final class EditProgramProvider
    extends $FunctionalProvider<EditProgram, EditProgram, EditProgram>
    with $Provider<EditProgram> {
  EditProgramProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'editProgramProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$editProgramHash();

  @$internal
  @override
  $ProviderElement<EditProgram> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  EditProgram create(Ref ref) {
    return editProgram(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(EditProgram value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<EditProgram>(value),
    );
  }
}

String _$editProgramHash() => r'1f7fc428634232784658386e6ca34b49e8c1b676';
