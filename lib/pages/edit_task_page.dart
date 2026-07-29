import 'package:daily/models/task.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EditTaskPage extends StatefulWidget {
  final Task? selectedTask;
  final ValueChanged<int> switchPage;
  final void Function(Task) onAddTask;
  final void Function(Task) onEditTask;

  const EditTaskPage({
    super.key,
    this.selectedTask,
    required this.switchPage,
    required this.onAddTask,
    required this.onEditTask
  });

  @override
  State<EditTaskPage> createState() => _EditTaskPageState();
}

class _EditTaskPageState extends State<EditTaskPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _notesController;
  late DateTime? _dueDate;
  late Priority _taskPriority;

  final List<bool> _priorityButtonsSelection = [false, false, false];

  // Initialize fields if editing a task
  @override
  void initState() {
    super.initState();
    if (widget.selectedTask != null) {
      _titleController = TextEditingController(text: widget.selectedTask!.title);
      _notesController = TextEditingController(text: widget.selectedTask!.notes,);
      _dueDate = widget.selectedTask!.dueDate;
      _taskPriority = widget.selectedTask!.priority;

      switch(_taskPriority) {
        case Priority.low:
          _priorityButtonsSelection[0] = true;
        case Priority.medium:
          _priorityButtonsSelection[1] = true;
        case Priority.high:
          _priorityButtonsSelection[2] = true;
      }

    } else {
      _titleController = TextEditingController();
      _notesController = TextEditingController();
      _dueDate = null;
      _taskPriority = Priority.low;
    }
  }  

  // Attempt to add task
  void _submit() {
    // Check if form is valid
    if (_formKey.currentState!.validate()) {
      widget.onAddTask(
        Task(
          title: _titleController.text,
          notes: _notesController.text,
          dueDate: _dueDate,
          priority: _taskPriority,
        ),
      );
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
              primary: Colors.blue[800]!,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(foregroundColor: Colors.blue[800]),
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
              primary: Colors.blue[800]!,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(foregroundColor: Colors.blue[800]),
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
                    // Go back to tasks page
                    Row(
                      spacing: 10,
                      children: [
                        IconButton(
                          onPressed: () => (widget.switchPage(0)),
                          icon: Icon(Icons.arrow_back),
                        ),
                        Text(
                          widget.selectedTask != null
                              ? "Edit Task"
                              : "Add Task",
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),

                    // Task name
                    TextFormField(
                      controller: _titleController,
                      validator: (value) => (value == null || value.isEmpty)
                          ? 'Title is required'
                          : null,
                      decoration: InputDecoration(
                        hintText: 'Task Name',
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.grey,
                        ),
                      ),
                    ),

                    // Notes
                    TextFormField(
                      controller: _notesController,
                      maxLines: 5,
                      decoration: InputDecoration(
                        hintText: 'Add notes ...',
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.grey,
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Due date
                    GestureDetector(
                      onTap: _showDatePicker,
                      child: Container(
                        padding: EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: const Color.fromARGB(255, 218, 218, 218),
                          ),
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
                                Icon(
                                  Icons.calendar_month_outlined,
                                  color: Colors.blue[800],
                                ),
                                Text(
                                  'Due Date',
                                  style: TextStyle(fontSize: 18),
                                ),
                                if (_dueDate != null)
                                  Text("(${DateFormat('MMM d, yyy').format(_dueDate!).toString()})"),
                              ],
                            ),
                            Icon(Icons.keyboard_arrow_right),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    // Priority buttons
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      spacing: 16,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          spacing: 6,
                          children: [
                            Icon(
                              Icons.flag,
                              size: 24,
                              color: Colors.red.shade800,
                            ),
                            Text('Priority', style: TextStyle(fontSize: 18)),
                          ],
                        ),
                        // Toggle buttons
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: const Color.fromARGB(255, 218, 218, 218),
                            ),
                          ),
                          child: ToggleButtons(
                            onPressed: (index) {
                              setState(() {
                                for (
                                  int i = 0;
                                  i < _priorityButtonsSelection.length;
                                  i++
                                ) {
                                  _priorityButtonsSelection[i] = i == index;

                                  if (_priorityButtonsSelection[i]) {
                                    _taskPriority = switch(i) {
                                      0 => Priority.low,
                                      1 => Priority.medium,
                                      2 => Priority.high,
                                      _ => Priority.low
                                    };
                                  }
                                }
                              });
                            },
                            selectedColor: Colors.black,
                            isSelected: _priorityButtonsSelection,
                            children: const [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 25),
                                child: Row(
                                  spacing: 10,
                                  children: [
                                    Icon(
                                      Icons.circle,
                                      size: 12,
                                      color: Colors.green,
                                    ),
                                    Text('Low'),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 25),
                                child: Row(
                                  spacing: 10,
                                  children: [
                                    Icon(
                                      Icons.circle,
                                      size: 12,
                                      color: Colors.yellow,
                                    ),
                                    Text('Medium'),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 25),
                                child: Row(
                                  spacing: 10,
                                  children: [
                                    Icon(
                                      Icons.circle,
                                      size: 12,
                                      color: Colors.red,
                                    ),
                                    Text('High'),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 100),

              // Save task button
              SizedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: widget.selectedTask == null ? _submit : () => widget.onEditTask ,
                      style: ButtonStyle(
                        foregroundColor: WidgetStateProperty.all<Color>(
                          Colors.white,
                        ),
                        backgroundColor: WidgetStateProperty.all<Color>(
                          Colors.blue.shade600,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 100,
                          vertical: 8,
                        ),
                        child: Row(
                          spacing: 10,
                          children: [
                            Text('Save Task', style: TextStyle(fontSize: 18)),
                            Icon(Icons.check, size: 22),
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
