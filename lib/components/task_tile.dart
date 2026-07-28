import 'package:daily/models/task.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

class TaskTile extends StatelessWidget {
  final Task task;
  final void Function(Task) completeTask;
  final void Function(Task) deleteTask;

  const TaskTile({
    super.key,
    required this.task,
    required this.completeTask,
    required this.deleteTask,
  });

  Color getTaskPriority() {
    switch (task.priority) {
      case Priority.low:
        return Colors.green.shade400;
      case Priority.medium:
        return Colors.yellow.shade500;
      case Priority.high:
        return Colors.red.shade400;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 8),

      child: Slidable(
        endActionPane: ActionPane(
          extentRatio: 0.2,
          motion: const ScrollMotion(),
          children: [
            // Delete task
            SlidableAction(
              onPressed: (context) => deleteTask(task),
              backgroundColor: Colors.red,
              icon: Icons.delete,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(8),
                bottomRight: Radius.circular(8),
              ),
            ),
          ],
        ),

        // Task tile
        child: Container(
          decoration: BoxDecoration(
            color: task.isDone ? const Color.fromARGB(255, 247, 247, 247) : Colors.white,
            border: Border(
              left: BorderSide(color: getTaskPriority(), width: 5),
            ),
            borderRadius: BorderRadius.circular(5),
            boxShadow: [BoxShadow(
              color: const Color.fromARGB(255, 235, 235, 235),
              spreadRadius: 1,
              blurRadius: 5,
            )]
          ),
          child: ListTile(
            onTap: () => completeTask(task),
            leading: task.isDone ? Icon(Icons.check_circle) : Icon(Icons.circle_outlined),
            title: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.title,
                    style: task.isDone ? TextStyle(decoration: TextDecoration.lineThrough) : null,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (task.dueDate != null)
                        Text(
                          DateFormat('h:mm a').format(task.dueDate!),
                          style: task.isDone ? TextStyle(decoration: TextDecoration.lineThrough) : null,
                        ),
                      
                      if (task.dueDate != null)
                        Text(
                          DateFormat('MMM dd').format(task.dueDate!),
                          style: task.isDone ? TextStyle(decoration: TextDecoration.lineThrough) : null,
                        ),
                    ],
                  ),
                ],
              ),
            )),
        )
      ),
    );
  }
}
