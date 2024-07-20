import 'package:appdev_proj/widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:appdev_proj/models/todo_model.dart';
import 'package:appdev_proj/screens/add_task_page.dart';
import 'package:appdev_proj/screens/task_details_page.dart';

class UpcomingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.primaryColor;
    final secondaryColor = theme.colorScheme.secondary;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Upcoming'),
        backgroundColor: primaryColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      drawer: AppDrawer(),
      body: Consumer<TodoModel>(
        builder: (context, model, child) {
          final List<Task> upcomingTasks = model.tasks.where((task) {
            return task.dueDate.isAfter(DateTime.now());
          }).toList();

          return ListView.builder(
            itemCount: upcomingTasks.length,
            itemBuilder: (context, index) {
              final task = upcomingTasks[index];
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
