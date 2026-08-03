// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'join_program.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(joinProgram)
final joinProgramProvider = JoinProgramProvider._();

final class JoinProgramProvider
    extends $FunctionalProvider<JoinProgram, JoinProgram, JoinProgram>
    with $Provider<JoinProgram> {
  JoinProgramProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'joinProgramProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$joinProgramHash();

  @$internal
  @override
  $ProviderElement<JoinProgram> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  JoinProgram create(Ref ref) {
    return joinProgram(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(JoinProgram value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<JoinProgram>(value),
    );
  }
}

String _$joinProgramHash() => r'779bbcdebc763195882d82a11534beab62b5225c';
