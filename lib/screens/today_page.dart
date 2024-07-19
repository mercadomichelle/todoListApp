import 'package:appdev_proj/screens/add_task_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/todo_model.dart'; // Adjust the path based on your project structure
import 'task_details_page.dart';

class TodayPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Today'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.today),
              title: Text('Today'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/today');
              },
            ),
            ListTile(
              leading: Icon(Icons.today),
              title: Text('Upcoming'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/upcoming');
              },
            ),
            ListTile(
              leading: Icon(Icons.sticky_note_2),
              title: Text('Sticky Wall'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/stickywall');
              },
            ),
            ListTile(
              leading: Icon(Icons.calendar_today),
              title: Text('Calendar'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/calendar');
              },
            ),
            ListTile(
              leading: Icon(Icons.format_list_bulleted),
              title: Text('Lists'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/lists');
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/settings');
              },
            ),
          ],
        ),
      ),
      body: Consumer<TodoModel>(
        builder: (context, model, child) {
          final List<Task> todayTasks = model.tasks.where((task) {
            return task.dueDate.year == DateTime.now().year &&
                task.dueDate.month == DateTime.now().month &&
                task.dueDate.day == DateTime.now().day;
          }).toList();

          return ListView.builder(
            itemCount: todayTasks.length,
            itemBuilder: (context, index) {
              final task = todayTasks[index];
              return ListTile(
                title: Text(task.title),
                subtitle: Text(task.description),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    model.removeTask(task); // Call removeTask method
                  },
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TaskDetailPage(task: task),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddTaskPage(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
