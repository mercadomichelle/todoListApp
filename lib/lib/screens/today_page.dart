import 'package:appdev_proj/screens/add_task_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/todo_model.dart';
import 'task_details_page.dart';

class TodayPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.primaryColor;
    final secondaryColor = theme.colorScheme.secondary;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Today'),
        backgroundColor: primaryColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
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
              leading: const Icon(Icons.format_list_bulleted),
              title: const Text('All Task'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/all-task');
              },
            ),
            ListTile(
              leading: const Icon(Icons.today),
              title: const Text('Today'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/today');
              },
            ),
            ListTile(
              leading: const Icon(Icons.today),
              title: const Text('Upcoming'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/upcoming');
              },
            ),
            ListTile(
              leading: const Icon(Icons.sticky_note_2),
              title: const Text('Sticky Wall'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/stickywall');
              },
            ),
            ListTile(
              leading: const Icon(Icons.calendar_today),
              title: const Text('Calendar'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/calendar');
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
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
              return Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  title:
                      Text(task.title, style: TextStyle(color: primaryColor)),
                  subtitle: Text(task.description),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.redAccent),
                    onPressed: () {
                      model.removeTask(task);
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
                ),
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
        backgroundColor: secondaryColor,
        child: const Icon(Icons.add),
      ),
    );
  }
}
