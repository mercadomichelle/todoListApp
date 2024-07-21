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
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditTaskPage(task: task),
                ),
              );
              // Force a rebuild to reflect the updated task details
              // Provider.of<TodoModel>(context, listen: false).notifyListeners();
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
          final updatedTask = todoModel.tasks.firstWhere(
            (t) => t.id == task.id,
            orElse: () => task,
          );
          final dueDateFormatted =
              DateFormat('MMMM dd, yyyy').format(updatedTask.dueDate);
          final createdDateFormatted =
              DateFormat('dd MMMM yyyy').format(updatedTask.creationDate);
          final createdTimeFormatted =
              DateFormat('HH:mm').format(updatedTask.creationDate);

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      updatedTask.title,
                      style: theme.textTheme.titleLarge?.copyWith(
                        color:
                            theme.textTheme.titleLarge?.color ?? Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12.0),
                    if (updatedTask.description?.isNotEmpty ?? false) ...[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.description, color: theme.iconTheme.color),
                          const SizedBox(width: 12.0),
                          Expanded(
                            child: Text(
                              updatedTask.description!,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: theme.textTheme.bodyMedium?.color ??
                                    Colors.black87,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12.0),
                    ],
                    Row(
                      children: [
                        Icon(Icons.calendar_today,
                            color: theme.iconTheme.color),
                        const SizedBox(width: 12.0),
                        Text(
                          'Due Date: $dueDateFormatted',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.textTheme.bodyMedium?.color ??
                                Colors.black87,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12.0),
                    Container(
                      constraints: const BoxConstraints(
                        minHeight: 550.0,
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          'Created at $createdDateFormatted | Time: $createdTimeFormatted',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.textTheme.bodyMedium?.color ??
                                Colors.grey,
                          ),
                        ),
                      ),
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
