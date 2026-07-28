class Task {
  String title;
  bool isDone;
  DateTime? dueDate;
  Priority priority;

  Task({
    required this.title,
    this.isDone = false,
    this.dueDate,
    this.priority = Priority.low,
  });
}

enum Priority { low, medium, high }