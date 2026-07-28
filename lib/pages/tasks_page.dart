import 'package:daily/components/task_tile.dart';
import 'package:daily/models/task.dart';
import 'package:flutter/material.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({super.key});

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  int _currentFilter = 0;

  // Mock data
  final List<Task> _tasks = <Task>[
    Task(
      title: 'Buy groceries',
      dueDate: DateTime(2026, 12, 1, 5),
      isDone: false,
      priority: Priority.low,
    ),
    Task(
      title: 'Design review with team',
      dueDate: DateTime(2026, 1, 1, 10, 30),
      isDone: false,
      priority: Priority.high,
    ),
    Task(
      title: 'Morning run',
      dueDate: DateTime(2026, 1, 1, 7),
      isDone: true,
      priority: Priority.medium,
    ),
    Task(
      title: 'Call mom',
      dueDate: DateTime(2026, 12, 1, 18),
      isDone: false,
      priority: Priority.low,
    ),
    Task(
      title: 'Today task',
      dueDate: DateTime(2026, 7, 28, 18),
      isDone: false,
      priority: Priority.low,
    ),
  ];

  // Mark task as complete
  void completeTask(Task task) {
    setState(() {
      task.isDone = !task.isDone;
    });
  }

  // Delete task
  void deleteTask(Task task) {
    setState(() {
      _tasks.remove(task);
    });
  }

  // Filter tasks helper
  List<Task> _getFilteredTasks() {
    final now = DateTime.now();
    final todayMidnight = DateTime.utc(now.year, now.month, now.day);
    switch (_currentFilter) {
      case 1:
        return _tasks
            .where(
              (task) =>
                  (task.dueDate != null && !task.isDone &&
                  DateTime.utc(
                    task.dueDate!.year,
                    task.dueDate!.month,
                    task.dueDate!.day,
                  ).isAtSameMomentAs(todayMidnight) ),
            )
            .toList();
      case 2:
        return _tasks
            .where(
              (task) =>
                  (task.dueDate != null && !task.isDone &&
                  task.dueDate!.isAfter(now)),
            )
            .toList();
      case 3:
        return _tasks.where((task) => (task.isDone)).toList();
      default:
        return _tasks;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 25),
      child: ListView(
        children: [
          // Filters
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 12,
            children: [

            for (final (index, label) in ['All', 'Today', 'Upcoming', 'Completed'].indexed)
              TextButton(
                onPressed: () {
                  setState(() {
                    _currentFilter = index;
                  });
                },
                style: TextButton.styleFrom(
                  textStyle: TextStyle(fontWeight: FontWeight.w400),
                  backgroundColor: _currentFilter == index
                      ? Colors.blueAccent[400]
                      : Colors.grey.shade300,
                  foregroundColor: _currentFilter == index
                      ? Colors.white
                      : Colors.black,
                ),
                child: Text(label),
              ),
            ],
          ),

          // Tasks
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                for (final task in _getFilteredTasks())
                  TaskTile(
                    key: ObjectKey(task),
                    task: task,
                    completeTask: completeTask,
                    deleteTask: deleteTask,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
