import 'package:daily/components/task_tile.dart';
import 'package:daily/models/task.dart';
import 'package:flutter/material.dart';

class TasksPage extends StatefulWidget {
  final List<Task> mockTasks;
  final void Function(Task) completeTask;
  final void Function(Task) deleteTask;
  const TasksPage({
    super.key,
    required this.mockTasks,
    required this.completeTask,
    required this.deleteTask,
  });

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  int _currentFilter = 0;

  // Filter tasks helper
  List<Task> _getFilteredTasks() {
    final now = DateTime.now();
    final todayMidnight = DateTime.utc(now.year, now.month, now.day);
    switch (_currentFilter) {
      case 1:
        return widget.mockTasks
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
        return widget.mockTasks
            .where(
              (task) =>
                  (task.dueDate != null && !task.isDone &&
                  task.dueDate!.isAfter(now)),
            )
            .toList();
      case 3:
        return widget.mockTasks.where((task) => (task.isDone)).toList();
      default:
        return widget.mockTasks;
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
                    completeTask: widget.completeTask,
                    deleteTask: widget.deleteTask,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
