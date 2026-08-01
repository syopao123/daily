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

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'notes': notes,
      'isDone': isDone ? 1 : 0,
      'dueDate': dueDate?.toIso8601String(),
      'priority': priority.index,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'] as String,
      title: map['title'] as String,
      notes: map['notes'] as String?,
      isDone: (map['isDone'] as int) == 1,
      dueDate: map['dueDate'] != null ? DateTime.parse(map['dueDate'] as String) : null,
      priority: Priority.values[map['priority'] as int],
    );
  }
}

enum Priority { low, medium, high }