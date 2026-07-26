class Task {
  String title;
  bool isDone;
  DateTime? dueDate;

  Task({required this.title, this.isDone = false, required this.dueDate});
}