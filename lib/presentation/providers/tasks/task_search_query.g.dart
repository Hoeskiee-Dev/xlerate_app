// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_search_query.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(TaskSearchQuery)
final taskSearchQueryProvider = TaskSearchQueryProvider._();

final class TaskSearchQueryProvider
    extends $NotifierProvider<TaskSearchQuery, String> {
  TaskSearchQueryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'taskSearchQueryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$taskSearchQueryHash();

  @$internal
  @override
  TaskSearchQuery create() => TaskSearchQuery();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$taskSearchQueryHash() => r'8e8578cc44d23f2a6107647a69ea97c82b012b85';

abstract class _$TaskSearchQuery extends $Notifier<String> {
  String build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<String, String>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<String, String>,
              String,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
