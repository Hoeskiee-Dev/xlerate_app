import 'package:flutter/material.dart';
import 'dart:math';

class Task {
  String title;
  String description;
  DateTime startDate;
  DateTime dueDate;
  String priority;
  bool isDone;

  Task({
    required this.title,
    required this.description,
    required this.startDate,
    required this.dueDate,
    required this.priority,
    this.isDone = false,
  });
}

class EventItem {
  final int day;
  final String title;
  EventItem(this.day, this.title);
}

class ProductivityScreen extends StatefulWidget {
  const ProductivityScreen({super.key});

  @override
  State<ProductivityScreen> createState() => _ProductivityScreenState();
}

class _ProductivityScreenState extends State<ProductivityScreen> {
  bool showCalendar = false;
  int weeklyStreak = 4; // TODO: calculate from real completion history

  DateTime get today => DateTime.now();
  DateTime displayedMonth = DateTime(DateTime.now().year, DateTime.now().month);

  final List<String> weekdays = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];
  List<EventItem> _currentMonthEvents = [];
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

  final List<String> _eventTitles = [
    'Quod Enchiridion Epictetus',
    'Team Sync Meeting',
    'Design Review',
    'Sprint Planning',
  ];

  final List<String> _motivationalTips = [
    "You're doing great — one task at a time!",
    "Small steps every day lead to big results.",
    "Focus on progress, not perfection.",
    "Consistency beats intensity. Keep going!",
  ];

  List<Task> tasks = [
    Task(
      title: 'Create app briefing',
      description:
          'Need to create app briefing like wireframe, app purpose, etc.',
      startDate: DateTime(2026, 7, 11),
      dueDate: DateTime(2026, 7, 13, 23, 59),
      priority: 'High',
    ),
    Task(
      title: 'Create app wireframe',
      description: 'Design low-fidelity wireframes for all core screens.',
      startDate: DateTime(2026, 7, 12),
      dueDate: DateTime(2026, 7, 14, 23, 59),
      priority: 'Medium',
    ),
    Task(
      title: 'Meeting for brief',
      description:
          'Team sync to review the app briefing before starting design.',
      startDate: DateTime(2026, 7, 13),
      dueDate: DateTime(2026, 7, 28, 23, 59),
      priority: 'Low',
      isDone: true,
    ),
  ];

  // Date and other help

  Color _priorityColor(String priority) {
    switch (priority) {
      case 'High':
        return Colors.orange;
      case 'Medium':
        return Colors.amber;
      case 'Low':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  EventItem? _programOnDay(int day) {
    for (var event in _currentMonthEvents) {
      if (event.day == day) return event;
    }
    return null;
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

  String _formatTime(DateTime dt) {
    int hour = dt.hour % 12;
    if (hour == 0) hour = 12;
    final period = dt.hour >= 12 ? 'PM' : 'AM';
    final minute = dt.minute.toString().padLeft(2, '0');
    return '$hour.$minute $period';
  }

  String _formatDateOnly(DateTime dt) =>
      '${dt.day} ${_monthName(dt.month)} ${dt.year}';

  String _formatDateWithTime(DateTime dt) =>
      '${_formatTime(dt)}, ${_formatDateOnly(dt)}';

  // today counts as "relevant" if it's on/after startDate and on/before dueDate
  bool _isRelevantToday(Task task) {
    final start = DateTime(
      task.startDate.year,
      task.startDate.month,
      task.startDate.day,
    );
    final due = DateTime(
      task.dueDate.year,
      task.dueDate.month,
      task.dueDate.day,
    );
    final todayOnly = DateTime(today.year, today.month, today.day);
    return !todayOnly.isBefore(start) && !todayOnly.isAfter(due);
  }

  List<Task> _tasksActiveOnDay(int day) {
    final date = DateTime(displayedMonth.year, displayedMonth.month, day);
    return tasks.where((task) {
      final start = DateTime(
        task.startDate.year,
        task.startDate.month,
        task.startDate.day,
      );
      final due = DateTime(
        task.dueDate.year,
        task.dueDate.month,
        task.dueDate.day,
      );
      return !date.isBefore(start) && !date.isAfter(due);
    }).toList();
  }

  Set<int> _taskDueDaysInDisplayedMonth() {
    Set<int> days = {};
    for (var task in tasks) {
      if (task.dueDate.year == displayedMonth.year &&
          task.dueDate.month == displayedMonth.month) {
        days.add(task.dueDate.day);
      }
    }
    return days;
  }

  // Random Program Generator
  List<EventItem> _generateEventsForMonth(DateTime month) {
    final seed = month.year * 100 + month.month;
    final random = Random(seed);
    final daysInMonth = _daysInMonth(month);

    int day1 = random.nextInt(daysInMonth) + 1;
    int day2 = random.nextInt(daysInMonth) + 1;
    while (day2 == day1) {
      day2 = random.nextInt(daysInMonth) + 1;
    }

    return [
      EventItem(day1, _eventTitles[random.nextInt(_eventTitles.length)]),
      EventItem(day2, _eventTitles[random.nextInt(_eventTitles.length)]),
    ];
  }

  //Task Popup
  void _showTaskPopup(Task task) {
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        task.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.close),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Text(
                  'Task Description',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  task.description,
                  style: TextStyle(color: Colors.grey[700]),
                ),
                const SizedBox(height: 16),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Start Date',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(height: 8),
                          _buildDashedLine(),
                          const SizedBox(height: 4),
                          Text(
                            _formatDateOnly(task.startDate),
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Column(
                        children: const [
                          SizedBox(height: 8),
                          Icon(
                            Icons.calendar_today,
                            size: 16,
                            color: Colors.deepPurple,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text(
                            'End Date',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(height: 8),
                          _buildDashedLine(),
                          const SizedBox(height: 4),
                          Text(
                            _formatDateOnly(task.dueDate),
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: task.isDone
                        ? null
                        : () {
                            setState(() {
                              task.isDone = true;
                            });
                            Navigator.pop(context);
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      foregroundColor: Colors.white,
                      disabledBackgroundColor: Colors.grey[300],
                      disabledForegroundColor: Colors.grey[600],
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(task.isDone ? 'Completed' : 'Mark as complete'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDashedLine() {
    return LayoutBuilder(
      builder: (context, constraints) {
        const dashWidth = 4.0;
        final dashCount = (constraints.constrainWidth() / (dashWidth * 2))
            .floor();
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: 1,
              child: DecoratedBox(
                decoration: BoxDecoration(color: Colors.grey[400]),
              ),
            );
          }),
        );
      },
    );
  }

  // Day Tasks
  void _showDayTasksPopup(int day) {
    final dayTasks = _tasksActiveOnDay(day);
    final program = _programOnDay(day);
    final dateLabel =
        '$day ${_monthName(displayedMonth.month)} ${displayedMonth.year}';

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
                  dateLabel,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 12),

                if (program != null) ...[
                  const Text(
                    'Registered Program',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.deepPurple.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.event,
                          color: Colors.deepPurple,
                          size: 18,
                        ),
                        const SizedBox(width: 8),
                        Expanded(child: Text(program.title)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                ],

                const Text(
                  'Tasks',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                ),
                const SizedBox(height: 6),
                if (dayTasks.isEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
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
                      subtitle: Text(task.priority),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () {
                        Navigator.pop(context);
                        _showTaskPopup(task);
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

  //Checklist

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
          color: color.withValues(alpha: 0.1),
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
        color: Colors.deepPurple.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          const Icon(Icons.emoji_objects, color: Colors.deepPurple),
          const SizedBox(width: 12),
          Expanded(
            child: Text(tip, style: const TextStyle(color: Colors.deepPurple)),
          ),
        ],
      ),
    );
  }

  Widget _buildChecklistView() {
    final relevantTasks = tasks.where(_isRelevantToday).toList();
    int completedCount = relevantTasks.where((task) => task.isDone).length;
    int totalCount = relevantTasks.length;

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
            color: Colors.deepPurple,
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
              value: '$weeklyStreak days',
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
              color: Colors.deepPurple,
            ),
          ],
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Today's Tasks",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            GestureDetector(
              onTap: () {
                // TODO: navigate to Task List screen
              },
              child: const Text(
                'See All',
                style: TextStyle(color: Colors.deepPurple),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        if (relevantTasks.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Text(
              'No tasks for today.',
              style: TextStyle(color: Colors.grey[500]),
            ),
          ),
        ...relevantTasks.map((task) {
          return GestureDetector(
            onTap: () => _showTaskPopup(task),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                children: [
                  Checkbox(
                    value: task.isDone,
                    onChanged: (bool? newValue) {
                      setState(() {
                        task.isDone = newValue!;
                      });
                    },
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          task.title,
                          style: TextStyle(
                            decoration: task.isDone
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                            color: task.isDone ? Colors.grey : Colors.black,
                          ),
                        ),
                        Text(
                          _formatDateWithTime(task.dueDate),
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: _priorityColor(
                        task.priority,
                      ).withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      task.priority,
                      style: TextStyle(
                        color: _priorityColor(task.priority),
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
        const SizedBox(height: 12),
        _buildMotivationCard(),
      ],
    );
  }

  // Calendar

  Widget _buildDayCell(
    int day,
    bool isTaskDay,
    bool isProgramDay,
    bool isToday,
  ) {
    return Stack(
      alignment: Alignment.center,
      children: [
        if (isProgramDay)
          Container(
            width: 28,
            height: 28,
            decoration: const BoxDecoration(
              color: Colors.deepPurple,
              shape: BoxShape.circle,
            ),
          ),
        if (isToday)
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.deepPurple, width: 2),
            ),
          ),
        Text(
          '$day',
          style: TextStyle(
            color: isProgramDay ? Colors.white : Colors.black,
            fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        if (isTaskDay)
          const Positioned(
            top: 2,
            right: 10,
            child: Icon(Icons.check, size: 12, color: Colors.deepPurple),
          ),
      ],
    );
  }

  //Calendar Grid
  Widget _buildCalendarGrid(Set<int> taskDueDays, Set<int> programDays) {
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
          onTap: () => _showDayTasksPopup(day),
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

  //Legend
  Widget _buildLegend() {
    return Row(
      children: [
        const Icon(Icons.check, size: 14, color: Colors.deepPurple),
        const SizedBox(width: 4),
        const Text('Task', style: TextStyle(fontSize: 12)),
        const SizedBox(width: 16),
        Container(
          width: 14,
          height: 14,
          decoration: const BoxDecoration(
            color: Colors.deepPurple,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 4),
        const Text('Registered Program', style: TextStyle(fontSize: 12)),
      ],
    );
  }

  //Upcoming
  Widget _buildUpcomingSection(List<EventItem> upcomingEvents) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Upcoming',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            GestureDetector(
              onTap: () {
                // TODO: navigate to full events/tasks list
              },
              child: const Text(
                'See All',
                style: TextStyle(color: Colors.deepPurple),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ...upcomingEvents.map((event) {
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.deepPurple.withValues(alpha: 0.15),
                  child: Text(
                    '${event.day}',
                    style: const TextStyle(
                      color: Colors.deepPurple,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(child: Text(event.title)),
                const Icon(Icons.chevron_right, color: Colors.grey),
              ],
            ),
          );
        }),
      ],
    );
  }

  //Calendar View
  Widget _buildCalendarView() {
    final upcomingEvents = _generateEventsForMonth(displayedMonth);
    _currentMonthEvents = upcomingEvents;
    final programDays = upcomingEvents.map((e) => e.day).toSet();
    final taskDueDays = _taskDueDaysInDisplayedMonth();

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
        _buildCalendarGrid(taskDueDays, programDays),
        const SizedBox(height: 12),
        _buildLegend(),
        const SizedBox(height: 24),
        _buildUpcomingSection(upcomingEvents),
      ],
    );
  }

  //Main
  @override
  Widget build(BuildContext context) {
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
                                color: Colors.deepPurple,
                                borderRadius: BorderRadius.circular(18),
                              ),
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    showCalendar = true;
                                  });
                                },
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
                                onTap: () {
                                  setState(() {
                                    showCalendar = false;
                                  });
                                },
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
                      child: showCalendar
                          ? _buildCalendarView()
                          : _buildChecklistView(),
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
}
