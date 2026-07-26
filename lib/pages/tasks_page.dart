import 'package:daily/components/task_tile.dart';
import 'package:daily/models/task.dart';
import 'package:flutter/material.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({super.key});

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  int _currentFilter = 0;

  final List<Task> _tasks = <Task>[
    Task(title: 'Buy groceries', dueDate: DateTime(2026, 12, 1, 17), isDone: false),
    Task(title: 'Design review with team', dueDate: DateTime(2026, 1, 1, 10, 30), isDone: false),
    Task(title: 'Morning run', dueDate: DateTime(2026, 1, 1, 7), isDone: true),
    Task(title: 'Call mom', dueDate: DateTime(2026, 12, 1, 18), isDone: false),
  ];

  void completeTask(int index) {

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
              TextButton(
                onPressed: () {
                  setState(() {
                    _currentFilter = 0;
                  });
                },
                style: TextButton.styleFrom(
                  textStyle: TextStyle(fontWeight: FontWeight.w400),
                  backgroundColor: _currentFilter == 0
                      ? Colors.deepPurple
                      : Colors.grey.shade300,
                  foregroundColor: _currentFilter == 0
                      ? Colors.white
                      : Colors.black,
                ),
                child: Text('All'),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    _currentFilter = 1;
                  });
                },
                style: TextButton.styleFrom(
                  textStyle: TextStyle(fontWeight: FontWeight.w400),
                  backgroundColor: _currentFilter == 1
                      ? Colors.deepPurple
                      : Colors.grey.shade300,
                  foregroundColor: _currentFilter == 1
                      ? Colors.white
                      : Colors.black,
                ),
                child: Text('Today'),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    _currentFilter = 2;
                  });
                },
                style: TextButton.styleFrom(
                  textStyle: TextStyle(fontWeight: FontWeight.w400),
                  backgroundColor: _currentFilter == 2
                      ? Colors.deepPurple
                      : Colors.grey.shade300,
                  foregroundColor: _currentFilter == 2
                      ? Colors.white
                      : Colors.black,
                ),
                child: Text('Upcoming'),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    _currentFilter = 3;
                  });
                },
                style: TextButton.styleFrom(
                  textStyle: TextStyle(fontWeight: FontWeight.w400),
                  backgroundColor: _currentFilter == 3
                      ? Colors.deepPurple
                      : Colors.grey.shade300,
                  foregroundColor: _currentFilter == 3
                      ? Colors.white
                      : Colors.black,
                ),
                child: Text('Completed'),
              ),
            ],
          ),

          // Tasks
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: _tasks.map((task) => TaskTile(task: task)).toList(),
            ),
          ),

          

        ],
      ),
    );
  }
}
