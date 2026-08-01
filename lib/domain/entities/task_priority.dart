import 'package:freezed_annotation/freezed_annotation.dart';

enum TaskPriority {
  @JsonValue("Low")
  low,

  @JsonValue("Medium")
  medium,

  @JsonValue("High")
  high;

  String get label {
    switch (this) {
      case TaskPriority.low:
        return 'Low';
      case TaskPriority.medium:
        return 'Medium';
      case TaskPriority.high:
        return 'High';
    }
  }
}
