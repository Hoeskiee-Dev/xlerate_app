// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_program_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(UpdateProgram)
final updateProgramProvider = UpdateProgramProvider._();

final class UpdateProgramProvider
    extends $AsyncNotifierProvider<UpdateProgram, void> {
  UpdateProgramProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'updateProgramProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$updateProgramHash();

  @$internal
  @override
  UpdateProgram create() => UpdateProgram();
}

String _$updateProgramHash() => r'8d1ac39cb9896c06ead7f385322fb11bf9c1e03c';

abstract class _$UpdateProgram extends $AsyncNotifier<void> {
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
