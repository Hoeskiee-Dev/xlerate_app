// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_detail_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(GetTaskInfo)
final getTaskInfoProvider = GetTaskInfoFamily._();

final class GetTaskInfoProvider
    extends $AsyncNotifierProvider<GetTaskInfo, Task?> {
  GetTaskInfoProvider._({
    required GetTaskInfoFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'getTaskInfoProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$getTaskInfoHash();

  @override
  String toString() {
    return r'getTaskInfoProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  GetTaskInfo create() => GetTaskInfo();

  @override
  bool operator ==(Object other) {
    return other is GetTaskInfoProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$getTaskInfoHash() => r'4824e0b7ad333d59982b830001d54647ffa480c0';

final class GetTaskInfoFamily extends $Family
    with
        $ClassFamilyOverride<
          GetTaskInfo,
          AsyncValue<Task?>,
          Task?,
          FutureOr<Task?>,
          String
        > {
  GetTaskInfoFamily._()
    : super(
        retry: null,
        name: r'getTaskInfoProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  GetTaskInfoProvider call(String taskId) =>
      GetTaskInfoProvider._(argument: taskId, from: this);

  @override
  String toString() => r'getTaskInfoProvider';
}

abstract class _$GetTaskInfo extends $AsyncNotifier<Task?> {
  late final _$args = ref.$arg as String;
  String get taskId => _$args;

  FutureOr<Task?> build(String taskId);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<Task?>, Task?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<Task?>, Task?>,
              AsyncValue<Task?>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}
