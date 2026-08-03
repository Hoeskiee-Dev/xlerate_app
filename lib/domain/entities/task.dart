import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';
import 'package:xlerate/domain/entities/task_priority.dart';

part 'task.freezed.dart';
part 'task.g.dart';

@freezed
abstract class Task with _$Task {
  const Task._();

  const factory Task({
    required String id,
    required String title,
    required String description,
    required int createdAt,
    required int startDate,
    required int endDate,
    required bool isDone,
    required TaskPriority priority,
    required String userId,
  }) = _Task;

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);

  String get formattedStartDate {
    final date = DateTime.fromMillisecondsSinceEpoch(startDate * 1000);
    return DateFormat('dd MMM yyyy').format(date);
  }

  String get formattedEndDate {
    final date = DateTime.fromMillisecondsSinceEpoch(endDate * 1000);
    return DateFormat('dd MMM yyyy').format(date);
  }
}
