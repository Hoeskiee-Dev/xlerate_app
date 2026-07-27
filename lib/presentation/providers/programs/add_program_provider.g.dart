// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_program_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AddProgram)
final addProgramProvider = AddProgramProvider._();

final class AddProgramProvider
    extends $AsyncNotifierProvider<AddProgram, void> {
  AddProgramProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'addProgramProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$addProgramHash();

  @$internal
  @override
  AddProgram create() => AddProgram();
}

String _$addProgramHash() => r'e3b2ba08162c49a06670a4e887e53765e9020df1';

abstract class _$AddProgram extends $AsyncNotifier<void> {
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
