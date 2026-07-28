import 'package:flutter/material.dart';

class AddTask extends StatelessWidget {
  final ValueChanged<int> switchPage;

  const AddTask({super.key, required this.switchPage});

  // Helper
  Widget getButton(String label) {
    return GestureDetector(
      onTap: () {},
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
                if (label.toLowerCase().contains('date'))
                  Icon(Icons.calendar_month_outlined, color: Colors.blue[800])
                else if (label.toLowerCase().contains('priority'))
                  Icon(Icons.circle, color: Colors.red, size: 14),
                Text(label, style: TextStyle(fontSize: 18)),
              ],
            ),
            Icon(Icons.keyboard_arrow_right),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 245, 244, 244),
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Column(
              spacing: 10,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  spacing: 10,
                  children: [
                    IconButton(onPressed: () => switchPage(0), icon: Icon(Icons.arrow_back)),
                    Text('New Task', style: TextStyle(fontSize: 20))
                  ],
                ),
                        
                // Task name
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Task Name',
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Colors.grey
                    )
                  )              
                ),
                        
                // Notes
                TextField(
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
                        
                // Due date button
                getButton('Due Date'),
                        
                // Priority button
                getButton('Priority'),
              ],
            ),

            // Save task button
            SizedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {},
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
    );
  }
}