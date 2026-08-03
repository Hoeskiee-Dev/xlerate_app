// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'apply_program_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ApplyProgram)
final applyProgramProvider = ApplyProgramProvider._();

final class ApplyProgramProvider
    extends $AsyncNotifierProvider<ApplyProgram, void> {
  ApplyProgramProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'applyProgramProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$applyProgramHash();

  @$internal
  @override
  ApplyProgram create() => ApplyProgram();
}

String _$applyProgramHash() => r'2fb30b9cd37996d0c563ee85dc8fe36aca1f857b';

abstract class _$ApplyProgram extends $AsyncNotifier<void> {
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
