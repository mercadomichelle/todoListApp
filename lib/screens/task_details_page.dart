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
        title: const Text(
          'Task Details',
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: theme.primaryColor,
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
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color.fromRGBO(250, 205, 126, 1),
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        updatedTask.title,
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color:
                              theme.textTheme.titleLarge?.color ?? Colors.black,
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      Row(
                        children: [
                          Icon(Icons.calendar_today,
                              color: theme.iconTheme.color),
                          const SizedBox(width: 12.0),
                          Text(
                            'Due Date: $dueDateFormatted',
                            style: TextStyle(
                              fontFamily: 'Ubuntu',
                              fontSize: 18,
                              color: theme.textTheme.bodyMedium?.color ??
                                  Colors.black87,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16.0),
                      if (updatedTask.description?.isNotEmpty ?? false) ...[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Icons.description,
                                color: theme.iconTheme.color),
                            const SizedBox(width: 12.0),
                            Expanded(
                              child: Text(
                                updatedTask.description!,
                                style: TextStyle(
                                  fontFamily: 'Ubuntu',
                                  fontSize: 18,
                                  color: theme.textTheme.bodyMedium?.color ??
                                      Colors.black87,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                      const SizedBox(height: 60.0),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Text(
                            'Created at $createdDateFormatted | Time: $createdTimeFormatted',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 16,
                              color: theme.textTheme.bodySmall?.color ??
                                  Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
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
        return Theme(
          data: ThemeData.light().copyWith(
            dialogBackgroundColor: const Color.fromARGB(255, 255, 238, 205),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.black,
              ),
            ),
          ),
          child: AlertDialog(
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
                  Provider.of<TodoModel>(context, listen: false)
                      .removeTask(task);
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
                child: const Text('Delete'),
              ),
            ],
          ),
        );
      },
    );
  }
}
