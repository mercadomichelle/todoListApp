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
    final primaryColor = theme.primaryColor;
    final secondaryColor = theme.colorScheme.secondary;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Details'),
        backgroundColor: primaryColor,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditTaskPage(task: task),
                ),
              );
              Provider.of<TodoModel>(context, listen: false).notifyListeners();
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
                      style: TextStyle(
                        fontSize: 28.0,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Row(
                      children: [
                        const Icon(Icons.description, color: Colors.grey),
                        const SizedBox(width: 10.0),
                        Expanded(
                          child: Text(
                            updatedTask.description,
                            style: const TextStyle(
                              fontSize: 18.0,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20.0),
                    Row(
                      children: [
                        const Icon(Icons.calendar_today, color: Colors.grey),
                        const SizedBox(width: 10.0),
                        Text(
                          'Due Date: $dueDateFormatted',
                          style: const TextStyle(
                            fontSize: 18.0,
                            color: Colors.black87,
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
}
