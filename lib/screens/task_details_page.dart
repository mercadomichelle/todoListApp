import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:appdev_proj/models/todo_model.dart';
import 'package:appdev_proj/screens/edit_task_page.dart';

class TaskDetailPage extends StatelessWidget {
  final Task task;

  TaskDetailPage({required this.task});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Details'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit, color: theme.iconTheme.color),
            onPressed: () async {
              // Await the result of the EditTaskPage and refresh the state.
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditTaskPage(task: task),
                ),
              );
              // Force a rebuild to reflect the updated task details
              Provider.of<TodoModel>(context, listen: false).notifyListeners();
            },
          ),
          IconButton(
            icon: Icon(Icons.delete, color: theme.iconTheme.color),
            onPressed: () {
              _confirmDelete(context);
            },
          ),
        ],
      ),
      body: Consumer<TodoModel>(
        builder: (context, todoModel, child) {
          // Attempt to find the updated task from the list
          final updatedTask = todoModel.tasks.firstWhere(
            (t) => t.id == task.id,
            orElse: () => task,
          );
          final dueDateFormatted =
              DateFormat('MMMM dd, yyyy').format(updatedTask.dueDate);

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      updatedTask.title,
                      style: theme.textTheme.headlineSmall?.copyWith(
                        color: theme.textTheme.headlineSmall?.color ??
                            Colors.blueAccent,
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    if (updatedTask.description?.isNotEmpty ?? false) ...[
                      Row(
                        children: [
                          Icon(Icons.description, color: theme.iconTheme.color),
                          const SizedBox(width: 10.0),
                          Expanded(
                            child: Text(
                              updatedTask.description!,
                              style: theme.textTheme.bodyLarge?.copyWith(
                                color: theme.textTheme.bodyLarge?.color ??
                                    Colors.black87,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20.0),
                    ],
                    Row(
                      children: [
                        Icon(Icons.calendar_today,
                            color: theme.iconTheme.color),
                        const SizedBox(width: 10.0),
                        Text(
                          'Due Date: $dueDateFormatted',
                          style: theme.textTheme.bodyLarge?.copyWith(
                            color: theme.textTheme.bodyLarge?.color ??
                                Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _confirmDelete(BuildContext context) {
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
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
