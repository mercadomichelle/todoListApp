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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditTaskPage(task: task),
                ),
              );
            },
          ),
        ],
      ),
      body: Consumer<TodoModel>(
        builder: (context, todoModel, child) {
          final updatedTask =
              todoModel.tasks.firstWhere((t) => t == task, orElse: () => task);
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
                      style: const TextStyle(
                        fontSize: 28.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
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
