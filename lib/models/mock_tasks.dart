// Temporary data
import 'package:daily/models/task.dart';

final List<Task> mockTasks = <Task>[
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
