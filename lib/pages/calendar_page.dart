import 'package:daily/components/task_tile.dart';
import 'package:daily/models/mock_tasks.dart';
import 'package:daily/models/task.dart';
import 'package:flutter/material.dart';

class CalendarPage extends StatefulWidget {
  final void Function(Task) toggleTask;
  final void Function(Task) editTask;
  final void Function(Task) deleteTask;

  const CalendarPage({
    super.key,
    required this.toggleTask,
    required this.editTask,
    required this.deleteTask,
  });

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime _selectedDate = DateTime.now();
  List<Task>? _tasks;

  final today = DateTime.now();

  void onDateChanged(DateTime date) {
    setState(() {
      _selectedDate = date;
      _tasks = mockTasks.where((task) {
        //if (task.dueDate == null) return false;
        return task.dueDate!.year == _selectedDate.year &&
            task.dueDate!.month == _selectedDate.month &&
            task.dueDate!.day == _selectedDate.day;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        // Calendar
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: const Color.fromARGB(255, 231, 231, 231))
            ),
            child: CalendarDatePicker(
              initialDate: DateTime.now(),
              firstDate: DateTime(2020),
              lastDate: DateTime(2031),
              onDateChanged: onDateChanged,
            ),
          ),
        ),
        const SizedBox(height: 14.0),
        // Scheduled Tasks
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Scheduled Tasks',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 12.0),
            if (_tasks != null)
              for (final task in _tasks!)
                TaskTile(
                  key: ObjectKey(task),
                  task: task,
                  toggleTask: widget.toggleTask,
                  deleteTask: widget.deleteTask,
                  editTask: widget.editTask,
                ),
          ],
        ),
      ],
    );
  }
}
