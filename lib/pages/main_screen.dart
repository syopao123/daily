import 'dart:ffi';

import 'package:daily/components/add_task.dart';
import 'package:daily/pages/calendar_page.dart';
import 'package:daily/pages/settings_page.dart';
import 'package:daily/pages/starred_page.dart';
import 'package:daily/pages/tasks_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  // Return selected page
  Widget? _getPage() {
    switch (_selectedIndex) {
      case 0:
        return TasksPage();
      case 1:
        return CalendarPage();
      case 2:
        return StarredPage();
      case 3:
        return SettingsPage();
      case 4:
        return AddTask(switchPage: switchPage);
    }
    return null;
  }

  // Switch page when bottom navbar item is tapped
  void switchPage(int index) {
    setState(() {
      _selectedIndex = index;
    });
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
              onPressed: () => switchPage(4),
              backgroundColor: Colors.blueAccent[400],
              foregroundColor: Colors.white,
              child: Icon(Icons.add),
            )
          : null,
      
      // Bottom navbar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex < 4 ? _selectedIndex : 0,
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
            icon: Icon(Icons.star_border_outlined),
            label: 'Starred',
            activeIcon: Icon(Icons.star),
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
