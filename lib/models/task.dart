import 'package:uuid/uuid.dart';

class Task {
  final String id;
  String title;
  String? notes;
  bool isDone;
  DateTime? dueDate;
  Priority priority;

  Task({
    String? id,
    required this.title,
    this.notes,
    this.isDone = false,
    this.dueDate,
    this.priority = Priority.low,
  }) : id = id ?? const Uuid().v4();
}

enum Priority { low, medium, high }