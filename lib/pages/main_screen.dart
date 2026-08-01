import 'package:daily/db/database_helper.dart';
import 'package:daily/pages/edit_task_page.dart';
import 'package:daily/models/task.dart';
import 'package:daily/pages/calendar_page.dart';
import 'package:daily/pages/settings_page.dart';
import 'package:daily/pages/tasks_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Task> _tasks = [];
  int _selectedIndex = 0;
  // Task to be edited
  Task? selectedTask;

  @override
  void initState() {
    super.initState();
    // Load tasks
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    final tasks = await DatabaseHelper.instance.getAllTasks();
    setState(() {
      _tasks = tasks;
    });
  }

  // Return selected page
  Widget? _getPage() {
    switch (_selectedIndex) {
      case 0:
        return TasksPage(
          toggleTask: toggleTask,
          deleteTask: deleteTask,
          tasks: _tasks,
          editTask: editTask
        );
      case 1:
        return CalendarPage(
          toggleTask: toggleTask,
          deleteTask: deleteTask,
          editTask: editTask,
        );
      case 2:
        return SettingsPage();
      case 3:
        return EditTaskPage(
          switchPage: switchPage,
          onAddTask: addTask,
          onEditTask: updateTask,
          selectedTask: selectedTask,
        );
    }
    return null;
  }

  // Show edit task page
  void editTask(Task task) {
    selectedTask = task;
    switchPage(3);
  }

  // Switch page when bottom navbar item is tapped
  void switchPage(int index) {
    if (index != 3) selectedTask = null;
    setState(() {
      _selectedIndex = index;
    });
  }

  // Add task
  Future<void> addTask(Task task) async {
    await DatabaseHelper.instance.insertTask(task);
    setState(() {
      _tasks.add(task);
      _selectedIndex = 0;
    });
  }

  // Update task
  Future<void> updateTask(Task task) async {
    await DatabaseHelper.instance.updateTask(task);
    setState(() {
      final index = _tasks.indexWhere((t) => t.id == task.id);
      if (index != -1) {
        _tasks[index] = task;
      }
      selectedTask = null;
      _selectedIndex = 0;
    });
  }

  // Delete task
  Future<void> deleteTask(Task task) async {
    await DatabaseHelper.instance.deleteTask(task.id);
    setState(() {
      _tasks.removeWhere((t) => t.id == task.id);
    });
  }

  // Toggle task
  Future<void> toggleTask(Task task) async {
    setState(() {
      task.isDone = !task.isDone;
    });
    await DatabaseHelper.instance.updateTask(task);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // App bar
      appBar: AppBar(
        leading: Container(
          padding: EdgeInsets.only(bottom: 15),
          child: Icon(Icons.calendar_month, size: 32, color: Colors.blue[600]),
        ),
        title: Container(
          padding: EdgeInsets.only(bottom: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Daily',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[600],
                ),
              ),
              Text(
                DateFormat('EEEE, MMMM d').format(DateTime.now()),
                style: TextStyle(fontSize: 12),
              ),
            ],
          ),
        ),
        actionsPadding: EdgeInsets.only(right: 12, bottom: 15),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))],
      ),

      body: _getPage(),

      // Floating action
      floatingActionButton: _selectedIndex == 0
          ? FloatingActionButton(
              onPressed: () => switchPage(3),
              backgroundColor: Colors.blueAccent[400],
              foregroundColor: Colors.white,
              child: Icon(Icons.add),
            )
          : null,
      
      // Bottom navbar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex < 3 ? _selectedIndex : 0,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue[700],
        iconSize: 26,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: switchPage,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.check),
            label: 'Tasks',
            activeIcon: Icon(Icons.check_circle),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month_outlined),
            label: 'Calendar',
            activeIcon: Icon(Icons.calendar_month),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            label: 'Settings',
            activeIcon: Icon(Icons.settings),
          ),
        ],
      ),
    );
  }
}
