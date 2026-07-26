// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'programs_list_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ProgramsList)
final programsListProvider = ProgramsListProvider._();

final class ProgramsListProvider
    extends $AsyncNotifierProvider<ProgramsList, List<Program>> {
  ProgramsListProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'programsListProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$programsListHash();

  @$internal
  @override
  ProgramsList create() => ProgramsList();
}

String _$programsListHash() => r'5594e5a21e6c56f9372451b9b8d77f439640fba3';

abstract class _$ProgramsList extends $AsyncNotifier<List<Program>> {
  FutureOr<List<Program>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<Program>>, List<Program>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Program>>, List<Program>>,
              AsyncValue<List<Program>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
