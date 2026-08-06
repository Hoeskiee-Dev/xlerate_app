import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'task_search_query.g.dart';

@riverpod
class TaskSearchQuery extends _$TaskSearchQuery {
  @override
  String build() => '';

  void setQuery(String query) {
    state = query;
  }

  void clear() {
    state = '';
  }
}
