import 'package:daily/models/task.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddTask extends StatefulWidget {
  final Task? newTask;
  final ValueChanged<int> switchPage;
  final void Function(Task) onAddTask;

  const AddTask({
    super.key,
    this.newTask,
    required this.switchPage,
    required this.onAddTask,
  });

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _notesController = TextEditingController();
  DateTime? _dueDate;

  // Helper
  Widget getButton(String label) {
    bool isDateButton = label.toLowerCase().contains('date');
    bool isPriorityButton = label.toLowerCase().contains('priority');

    return GestureDetector(
      onTap: label.toLowerCase().contains('date') ? _showDatePicker :() {},
      child: Container(
        padding: EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: const Color.fromARGB(255, 218, 218, 218)),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 10,
              children: [
                if (isDateButton)
                  Icon(Icons.calendar_month_outlined, color: Colors.blue[800]),
                if (isPriorityButton)
                  Icon(Icons.circle, color: Colors.red, size: 14),
                Text(label, style: TextStyle(fontSize: 18)),

                if (isDateButton && _dueDate != null) Text('(${DateFormat('MMM d').format(_dueDate!)})'),
              ],
            ),
            Icon(Icons.keyboard_arrow_right),
          ],
        ),
      ),
    );
  }

  // Attempt to add task
  void _submit() {
    // Check if form is valid
    if (_formKey.currentState!.validate()) {
      widget.onAddTask(Task(
        title: _titleController.text,
        notes: _notesController.text,
        dueDate: _dueDate
      ));
    }
  }
  
  // Show date & time picker when button is clicked
  void _showDatePicker() async {
    final date = await showDatePicker(
      context: context,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            // Colors configured to match your blue calendar icon
            colorScheme: ColorScheme.light(
              primary:
                  Colors.blue[800]!,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor:
                    Colors.blue[800]
              ),
            ),
          ),
          child: child!,
        );
      },
      initialDate: _dueDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (date == null) return; // user cancelled

    if (!mounted) return;
    final time = await showTimePicker(
      context: context,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            // Colors configured to match your blue calendar icon
            colorScheme: ColorScheme.light(
              primary:
                  Colors.blue[800]!,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor:
                    Colors.blue[800]
              ),
            ),
          ),
          child: child!,
        );
      },
      initialTime: TimeOfDay.now(),
    );
    if (time == null) return; // user cancelled

    setState(() {
      _dueDate = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: const Color.fromARGB(255, 245, 244, 244),
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  spacing: 10,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      spacing: 10,
                      children: [
                        IconButton(onPressed: () => widget.switchPage(0), icon: Icon(Icons.arrow_back)),
                        Text('New Task', style: TextStyle(fontSize: 20))
                      ],
                    ),
                            
                    // Task name
                    TextFormField(
                      controller: _titleController,
                      validator: (value) => (value == null || value.isEmpty) ? 'Title is required' : null,
                      decoration: InputDecoration(
                        hintText: 'Task Name',
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.grey
                        )
                      )              
                    ),
                            
                    // Notes
                    TextFormField(
                      controller: _notesController,
                      maxLines: 5,
                      decoration: InputDecoration(
                        hintText: 'Add notes ...',
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.grey
                        )
                      ),
                    ),
                    
                    const SizedBox(height: 20),
                            
                    // Due date
                    getButton('Due Date'),
                            
                    // Priority
                    getButton('Priority'),
                  ],
                ),
              ),

              const SizedBox(height: 70),
      
              // Save task button
              SizedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: _submit,
                      style: ButtonStyle(
                        foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
                        backgroundColor: WidgetStateProperty.all<Color>(Colors.blue.shade900),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 100,vertical: 8),
                        child: Row(
                          spacing: 10,
                          children: [
                            Text('Save Task', style: TextStyle(fontSize: 18)),
                            Icon(Icons.check, size: 22)
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}