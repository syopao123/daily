class Task {
  String title;
  String? notes;
  bool isDone;
  DateTime? dueDate;
  Priority priority;

  Task({
    required this.title,
    this.notes,
    this.isDone = false,
    this.dueDate,
    this.priority = Priority.low,
  });
}

enum Priority { low, medium, high }