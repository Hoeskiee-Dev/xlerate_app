import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xlerate/presentation/providers/tasks/tasks_list_provider.dart';

final streakProvider = Provider<int>((ref) {
  final tasksAsync = ref.watch(tasksListProvider);

  return tasksAsync.when(
    data: (tasks) {
      final completedTasks = tasks.where((task) => task.isDone).toList();

      if (completedTasks.isEmpty) return 0;

      final completedDates = completedTasks
          .map((task) {
            final date = DateTime.fromMillisecondsSinceEpoch(
              task.endDate * 1000,
            );
            return DateTime(date.year, date.month, date.day);
          })
          .toSet()
          .toList();

      completedDates.sort((a, b) => b.compareTo(a));

      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      final yesterday = today.subtract(const Duration(days: 1));

      final hasCompletedToday = completedDates.contains(today);
      final hasCompletedYesterday = completedDates.contains(yesterday);

      if (!hasCompletedToday && !hasCompletedYesterday) {
        return 0;
      }

      int streak = 0;
      DateTime checkDate = hasCompletedToday ? today : yesterday;

      while (completedDates.contains(checkDate)) {
        streak++;
        checkDate = checkDate.subtract(const Duration(days: 1));
      }

      return streak;
    },
    loading: () => 0,
    error: (_, _) => 0,
  );
});
