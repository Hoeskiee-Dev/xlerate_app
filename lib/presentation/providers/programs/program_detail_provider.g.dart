// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'program_detail_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(programDetail)
final programDetailProvider = ProgramDetailFamily._();

final class ProgramDetailProvider
    extends $FunctionalProvider<AsyncValue<Program>, Program, FutureOr<Program>>
    with $FutureModifier<Program>, $FutureProvider<Program> {
  ProgramDetailProvider._({
    required ProgramDetailFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'programDetailProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$programDetailHash();

  @override
  String toString() {
    return r'programDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<Program> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Program> create(Ref ref) {
    final argument = this.argument as String;
    return programDetail(ref, id: argument);
  }

  @override
  bool operator ==(Object other) {
    return other is ProgramDetailProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$programDetailHash() => r'd5de150b4fa0ce29d2faa5bff685cef28dc3b53a';

final class ProgramDetailFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<Program>, String> {
  ProgramDetailFamily._()
    : super(
        retry: null,
        name: r'programDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ProgramDetailProvider call({required String id}) =>
      ProgramDetailProvider._(argument: id, from: this);

  @override
  String toString() => r'programDetailProvider';
}
