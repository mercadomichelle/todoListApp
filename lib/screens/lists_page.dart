import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:appdev_proj/models/todo_model.dart';
import 'package:appdev_proj/screens/task_details_page.dart';
import 'package:appdev_proj/screens/add_task_page.dart';
import 'package:appdev_proj/widgets/app_drawer.dart';
import 'package:intl/intl.dart';

class ListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('All Tasks'),
        backgroundColor: theme.appBarTheme.backgroundColor,
      ),
      drawer: AppDrawer(),
      body: Container(
        color: theme.scaffoldBackgroundColor,
        child: Consumer<TodoModel>(
          builder: (context, model, child) {
            final List<Task> allTasks = model.tasks;

            return ListView.builder(
              itemCount: allTasks.length,
              itemBuilder: (context, index) {
                final task = allTasks[index];
                final dueDateFormatted =
                    DateFormat('MMMM dd, yyyy').format(task.dueDate);

                return Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 4,
                    color: theme.cardColor,
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 16.0),
                      title: Text(
                        task.title,
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: theme.textTheme.bodyLarge?.color,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        '${task.description?.isNotEmpty ?? false ? task.description : 'No Description'}\nDue Date: $dueDateFormatted',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.textTheme.bodyMedium?.color,
                        ),
                      ),
                      trailing: IconButton(
                        icon:
                            Icon(Icons.delete, color: theme.colorScheme.error),
                        onPressed: () {
                          _confirmDelete(context, task);
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
                  ),
                );
              },
            );
          },
        ),
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
        backgroundColor: theme.floatingActionButtonTheme.backgroundColor,
        child: const Icon(Icons.add),
      ),
    );
  }

  void _confirmDelete(BuildContext context, Task task) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Task'),
          content: const Text('Are you sure you want to delete this task?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Provider.of<TodoModel>(context, listen: false).removeTask(task);
                Navigator.of(context).pop();
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
