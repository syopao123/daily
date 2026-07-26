import 'package:daily/models/task.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TaskTile extends StatelessWidget {
  Task task;
  TaskTile({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 7),
      margin: EdgeInsets.only(bottom: 15),
      width: 340,
      decoration: BoxDecoration(
        color: task.isDone ? Colors.white70 : Colors.white,
        border: Border.all(color: Colors.black12, width: 0.5),
        borderRadius: BorderRadius.circular(8)
      ),
      child: ListTile(
        // Checkbox
        leading: Icon(
          task.isDone ? Icons.check_circle : Icons.circle_outlined,
          color: task.isDone ? Colors.green.shade300 : Colors.black45,
          size: 26,
        ),
        titleAlignment: ListTileTitleAlignment.titleHeight,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Task name
            Text(
              task.title,
              style: TextStyle(
                color: Colors.black,
                decoration: task.isDone
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
              ),
            ),

            // Task due date
            if (task.dueDate != null)
              Row(
                spacing: 5,
                children: [
                  if (task.dueDate!.isAfter(DateTime.now()))
                    Icon(Icons.circle, color: Colors.green, size: 10)
                  else if (task.dueDate!.isBefore(DateTime.now()) &&
                      !task.isDone)
                    Icon(Icons.circle, color: Colors.red, size: 10)
                  else
                    Icon(Icons.circle, color: Colors.yellow.shade400, size: 10),

                  Text(
                    DateFormat('h:mm a').format(task.dueDate!),
                    style: TextStyle(
                      fontSize: 14,
                      decoration: task.isDone
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
