import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xlerate/domain/entities/program.dart';
import 'package:xlerate/domain/entities/task.dart';
import 'package:xlerate/domain/entities/task_priority.dart';
import 'package:xlerate/presentation/misc/colors.dart';
import 'package:xlerate/presentation/pages/productivity/methods/task_detail_dialog.dart';
import 'package:xlerate/presentation/pages/productivity/task_list_page.dart';
import 'package:xlerate/presentation/providers/programs/attended_program_provider.dart';
import 'package:xlerate/presentation/providers/tasks/streak_provider.dart';
import 'package:xlerate/presentation/providers/tasks/tasks_list_provider.dart';

class ProductivityScreen extends ConsumerStatefulWidget {
  const ProductivityScreen({super.key});

  @override
  ConsumerState<ProductivityScreen> createState() => _ProductivityScreenState();
}

class _ProductivityScreenState extends ConsumerState<ProductivityScreen> {
  bool showCalendar = false;

  DateTime get today => DateTime.now();
  late DateTime displayedMonth;

  final List<String> weekdays = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];
  static const List<String> _monthNames = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  final List<String> _motivationalTips = [
    "You're doing great — one task at a time!",
    "Small steps every day lead to big results.",
    "Focus on progress, not perfection.",
    "Consistency beats intensity. Keep going!",
  ];

  @override
  void initState() {
    super.initState();
    displayedMonth = DateTime(today.year, today.month);
  }

  Color _priorityColor(TaskPriority priority) {
    switch (priority) {
      case TaskPriority.high:
        return highPriorityTextColor;
      case TaskPriority.medium:
        return mediumPriorityTextColor;
      case TaskPriority.low:
        return lowPriorityTextColor;
    }
  }

  Color _priorityBackgroundColor(TaskPriority priority) {
    switch (priority) {
      case TaskPriority.high:
        return highPriorityBorderColor;
      case TaskPriority.medium:
        return mediumPriorityBorderColor;
      case TaskPriority.low:
        return lowPriorityBorderColor;
    }
  }

  String _monthName(int month) => _monthNames[month - 1];

  int _daysInMonth(DateTime month) {
    final firstDayNextMonth = DateTime(month.year, month.month + 1, 1);
    final lastDayThisMonth = firstDayNextMonth.subtract(
      const Duration(days: 1),
    );
    return lastDayThisMonth.day;
  }

  int _firstWeekday(DateTime month) {
    final firstDay = DateTime(month.year, month.month, 1);
    return firstDay.weekday % 7;
  }

  List<Task> _filterTodayTasks(List<Task> tasks) {
    final startOfToday =
        DateTime(today.year, today.month, today.day).millisecondsSinceEpoch ~/
        1000;
    final endOfToday =
        DateTime(
          today.year,
          today.month,
          today.day,
          23,
          59,
          59,
        ).millisecondsSinceEpoch ~/
        1000;

    return tasks.where((task) {
      return task.startDate <= endOfToday && task.endDate >= startOfToday;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final tasksAsync = ref.watch(tasksListProvider);
    final attendedProgramsAsync = ref.watch(attendedProgramProvider);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  const Text(
                    'Productivity',
                    style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),

                  Container(
                    height: 44,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(22),
                    ),
                    child: Stack(
                      children: [
                        AnimatedAlign(
                          duration: const Duration(milliseconds: 200),
                          alignment: showCalendar
                              ? Alignment.centerLeft
                              : Alignment.centerRight,
                          child: FractionallySizedBox(
                            widthFactor: 0.5,
                            child: Container(
                              margin: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: Colors.deepOrangeAccent,
                                borderRadius: BorderRadius.circular(18),
                              ),
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () =>
                                    setState(() => showCalendar = true),
                                child: Center(
                                  child: Text(
                                    'Calendar',
                                    style: TextStyle(
                                      color: showCalendar
                                          ? Colors.white
                                          : Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () =>
                                    setState(() => showCalendar = false),
                                child: Center(
                                  child: Text(
                                    'Checklist',
                                    style: TextStyle(
                                      color: !showCalendar
                                          ? Colors.white
                                          : Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  Expanded(
                    child: SingleChildScrollView(
                      child: tasksAsync.when(
                        data: (tasks) {
                          return attendedProgramsAsync.when(
                            data: (userPrograms) {
                              return showCalendar
                                  ? _buildCalendarView(tasks, userPrograms)
                                  : _buildChecklistView(tasks);
                            },
                            loading: () => const Center(
                              child: Padding(
                                padding: EdgeInsets.all(32.0),
                                child: CircularProgressIndicator(),
                              ),
                            ),
                            error: (err, _) => Center(
                              child: Text(
                                'Error loading programs: $err',
                                style: const TextStyle(color: Colors.red),
                              ),
                            ),
                          );
                        },
                        loading: () => const Center(
                          child: Padding(
                            padding: EdgeInsets.all(32.0),
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        error: (err, stack) => Center(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              "Failed to load tasks: ${err.toString()}",
                              style: const TextStyle(color: Colors.red),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildChecklistView(List<Task> allTasks) {
    final todayTasks = _filterTodayTasks(allTasks);
    final completedCount = todayTasks.where((t) => t.isDone).length;
    final totalCount = todayTasks.length;
    final streakCount = ref.watch(streakProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Today's Progress",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(
          '$completedCount/$totalCount',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: totalCount == 0 ? 0 : completedCount / totalCount,
            backgroundColor: Colors.grey[300],
            color: Colors.deepOrangeAccent,
            minHeight: 8,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Task Completed',
          style: TextStyle(color: Colors.grey, fontSize: 12),
        ),
        const SizedBox(height: 24),

        Row(
          children: [
            _buildStatCard(
              icon: Icons.local_fire_department,
              value: '$streakCount days',
              label: 'Current streak',
              color: Colors.orange,
            ),
            const SizedBox(width: 12),
            _buildStatCard(
              icon: Icons.check_circle,
              value: totalCount == 0
                  ? '0%'
                  : '${((completedCount / totalCount) * 100).round()}%',
              label: 'Completion rate',
              color: Colors.deepOrangeAccent,
            ),
          ],
        ),
        const SizedBox(height: 24),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Today's Tasks",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const TaskListPage()),
                );
              },
              child: const Text(
                'See All',
                style: TextStyle(
                  color: Colors.deepOrangeAccent,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),

        if (todayTasks.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Text(
              'No tasks for today.',
              style: TextStyle(color: Colors.grey[500]),
            ),
          )
        else
          ...todayTasks.map((task) => _buildTodayTaskCard(task)),

        const SizedBox(height: 16),
        _buildMotivationCard(),
      ],
    );
  }

  Widget _buildTodayTaskCard(Task task) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => showTaskDetailDialog(context, task),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.black87,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Text(
                        task.description.isEmpty
                            ? 'No description'
                            : task.description,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 13,
                          height: 1.3,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: _priorityBackgroundColor(task.priority),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        task.priority.label,
                        style: TextStyle(
                          color: _priorityColor(task.priority),
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String value,
    required String label,
    required Color color,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              label,
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMotivationCard() {
    final tip = _motivationalTips[today.day % _motivationalTips.length];
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.deepOrangeAccent.withOpacity(0.08),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          const Icon(Icons.emoji_objects, color: Colors.deepOrangeAccent),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              tip,
              style: const TextStyle(color: Colors.deepOrangeAccent),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCalendarView(List<Task> allTasks, List<Program> userPrograms) {
    final taskDueDays = _taskDueDaysInDisplayedMonth(allTasks);

    final programDays = userPrograms
        .where((p) {
          final pDate = p.parsedStartDate;
          return pDate != null &&
              pDate.year == displayedMonth.year &&
              pDate.month == displayedMonth.month;
        })
        .map((p) => p.parsedStartDate!.day)
        .toSet();

    final todayStart = DateTime(today.year, today.month, today.day);
    final upcomingPrograms = userPrograms.where((p) {
      final pDate = p.parsedStartDate;
      if (pDate == null) return false;
      return pDate.isAfter(todayStart.subtract(const Duration(days: 1)));
    }).toList();

    upcomingPrograms.sort((a, b) {
      final aDate = a.parsedStartDate ?? DateTime(2099);
      final bDate = b.parsedStartDate ?? DateTime(2099);
      return aDate.compareTo(bDate);
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey.shade400),
              ),
              child: IconButton(
                icon: const Icon(Icons.chevron_left),
                onPressed: () {
                  setState(() {
                    displayedMonth = DateTime(
                      displayedMonth.year,
                      displayedMonth.month - 1,
                    );
                  });
                },
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  '${_monthName(displayedMonth.month)} ${displayedMonth.year}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey.shade400),
              ),
              child: IconButton(
                icon: const Icon(Icons.chevron_right),
                onPressed: () {
                  setState(() {
                    displayedMonth = DateTime(
                      displayedMonth.year,
                      displayedMonth.month + 1,
                    );
                  });
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: weekdays.map((day) {
            return Expanded(
              child: Center(
                child: Text(
                  day,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 8),
        _buildCalendarGrid(taskDueDays, programDays, allTasks, userPrograms),
        const SizedBox(height: 20),

        Row(
          children: [
            const Icon(Icons.check, size: 14, color: Colors.deepOrangeAccent),
            const SizedBox(width: 4),
            Text(
              'Task Due',
              style: TextStyle(fontSize: 12, color: Colors.grey[700]),
            ),
            const SizedBox(width: 16),
            Container(
              width: 10,
              height: 10,
              decoration: const BoxDecoration(
                color: Colors.deepOrangeAccent,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 6),
            Text(
              'Program Event',
              style: TextStyle(fontSize: 12, color: Colors.grey[700]),
            ),
          ],
        ),
        const SizedBox(height: 24),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Upcoming',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ],
        ),
        const SizedBox(height: 12),

        if (upcomingPrograms.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: Center(
              child: Text(
                'no event attended',
                style: TextStyle(color: Colors.grey[500], fontSize: 14),
              ),
            ),
          )
        else
          ...upcomingPrograms.map((program) => _buildUpcomingCard(program)),
      ],
    );
  }

  Set<int> _taskDueDaysInDisplayedMonth(List<Task> allTasks) {
    Set<int> days = {};
    for (var task in allTasks) {
      final dueDate = DateTime.fromMillisecondsSinceEpoch(task.endDate * 1000);
      if (dueDate.year == displayedMonth.year &&
          dueDate.month == displayedMonth.month) {
        days.add(dueDate.day);
      }
    }
    return days;
  }

  Widget _buildCalendarGrid(
    Set<int> taskDueDays,
    Set<int> programDays,
    List<Task> allTasks,
    List<Program> userPrograms,
  ) {
    int daysInMonth = _daysInMonth(displayedMonth);
    int firstWeekday = _firstWeekday(displayedMonth);

    List<Widget> dayCells = [];

    for (int i = 0; i < firstWeekday; i++) {
      dayCells.add(const SizedBox());
    }

    for (int day = 1; day <= daysInMonth; day++) {
      final isToday =
          displayedMonth.year == today.year &&
          displayedMonth.month == today.month &&
          day == today.day;

      dayCells.add(
        GestureDetector(
          onTap: () => _showDayTasksPopup(day, allTasks, userPrograms),
          child: _buildDayCell(
            day,
            taskDueDays.contains(day),
            programDays.contains(day),
            isToday,
          ),
        ),
      );
    }

    return GridView.count(
      crossAxisCount: 7,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: dayCells,
    );
  }

  Widget _buildDayCell(
    int day,
    bool isTaskDay,
    bool isProgramDay,
    bool isToday,
  ) {
    return Stack(
      alignment: Alignment.center,
      children: [
        if (isToday)
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.deepOrangeAccent, width: 2),
            ),
          ),
        if (isProgramDay)
          Container(
            width: 28,
            height: 28,
            decoration: const BoxDecoration(
              color: Colors.deepOrangeAccent,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '$day',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
        else
          Text(
            '$day',
            style: TextStyle(
              fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        if (isTaskDay && !isProgramDay)
          const Positioned(
            top: 2,
            right: 8,
            child: Icon(Icons.check, size: 12, color: Colors.deepOrangeAccent),
          ),
      ],
    );
  }

  Widget _buildUpcomingCard(Program program) {
    final programDate = program.parsedStartDate;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: Colors.deepOrangeAccent,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                programDate != null ? '${programDate.day}' : '-',
                style: const TextStyle(
                  color: Colors.deepOrangeAccent,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  program.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    color: Colors.black87,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                if (program.time.isNotEmpty) ...[
                  const SizedBox(height: 2),
                  Text(
                    program.time,
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                ],
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: Colors.grey),
        ],
      ),
    );
  }

  void _showDayTasksPopup(
    int day,
    List<Task> allTasks,
    List<Program> userPrograms,
  ) {
    final selectedDate = DateTime(
      displayedMonth.year,
      displayedMonth.month,
      day,
    );
    final startOfSelectedDay =
        DateTime(
          selectedDate.year,
          selectedDate.month,
          selectedDate.day,
        ).millisecondsSinceEpoch ~/
        1000;
    final endOfSelectedDay =
        DateTime(
          selectedDate.year,
          selectedDate.month,
          selectedDate.day,
          23,
          59,
          59,
        ).millisecondsSinceEpoch ~/
        1000;

    final dayTasks = allTasks.where((task) {
      return task.startDate <= endOfSelectedDay &&
          task.endDate >= startOfSelectedDay;
    }).toList();

    final dayPrograms = userPrograms.where((p) {
      final pDate = p.parsedStartDate;
      return pDate != null &&
          pDate.year == selectedDate.year &&
          pDate.month == selectedDate.month &&
          pDate.day == selectedDate.day;
    }).toList();

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$day ${_monthName(displayedMonth.month)} ${displayedMonth.year}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 12),
                if (dayPrograms.isNotEmpty) ...[
                  const Text(
                    'Programs',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: Colors.deepOrangeAccent,
                    ),
                  ),
                  const SizedBox(height: 6),
                  ...dayPrograms.map(
                    (p) => ListTile(
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(
                        Icons.event,
                        color: Colors.deepOrangeAccent,
                      ),
                      title: Text(p.title),
                      subtitle: Text(p.time),
                    ),
                  ),
                  const Divider(),
                ],
                const Text(
                  'Tasks',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                ),
                const SizedBox(height: 6),
                if (dayTasks.isEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      'No tasks for this date.',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  )
                else
                  ...dayTasks.map((task) {
                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        task.title,
                        style: TextStyle(
                          decoration: task.isDone
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                      ),
                      subtitle: Text(task.priority.label),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () {
                        Navigator.pop(context);
                        showTaskDetailDialog(context, task);
                      },
                    );
                  }),
              ],
            ),
          ),
        );
      },
    );
  }
}
