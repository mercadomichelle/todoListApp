import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:appdev_proj/models/todo_model.dart';
import 'package:appdev_proj/functions/edit_task.dart';
import 'package:appdev_proj/functions/delete_task.dart';

class TaskDetailPage extends StatelessWidget {
  final Task task;

  TaskDetailPage({required this.task});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final brightness = theme.brightness;
    final isDarkMode = brightness == Brightness.dark;
    final backgroundImage =
        isDarkMode ? 'assets/images/bg3.jpg' : 'assets/images/bg1.jpg';

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              backgroundImage,
              fit: BoxFit.cover,
            ),
          ),
          // Page content
          Column(
            children: [
              AppBar(
                title: const Text('Task Details'),
                backgroundColor: theme.primaryColor,
                actions: [
                  IconButton(
                    icon: Icon(Icons.edit, color: theme.iconTheme.color),
                    onPressed: () async {
                      final updatedTask = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditTaskPage(task: task),
                        ),
                      );
                      if (updatedTask != null) {
                        // Update task in the model
                        // ignore: use_build_context_synchronously
                        Provider.of<TodoModel>(context, listen: false)
                            .updateTask(task, updatedTask);
                      }
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete, color: theme.iconTheme.color),
                    onPressed: () {
                      DeleteTaskDialog.show(
                          context, task); // Use the new delete dialog
                    },
                  ),
                ],
              ),
              Expanded(
                child: Consumer<TodoModel>(
                  builder: (context, todoModel, child) {
                    final updatedTask = todoModel.tasks.firstWhere(
                      (t) => t.id == task.id,
                      orElse: () => task,
                    );
                    final dueDateFormatted =
                        DateFormat('MMMM dd, yyyy').format(updatedTask.dueDate);
                    final createdDateFormatted = DateFormat('dd MMMM yyyy')
                        .format(updatedTask.creationDate);
                    final createdTimeFormatted =
                        DateFormat('HH:mm').format(updatedTask.creationDate);

                    Color priorityColor;
                    switch (updatedTask.priority) {
                      case 3:
                        priorityColor = Colors.red;
                        break;
                      case 2:
                        priorityColor = Colors.orange;
                        break;
                      default:
                        priorityColor = Colors.green;
                        break;
                    }

                    return SingleChildScrollView(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: priorityColor, width: 2),
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
                                    color: theme.textTheme.titleLarge?.color ??
                                        Colors.black,
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
                                        color:
                                            theme.textTheme.bodyMedium?.color ??
                                                Colors.black87,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16.0),
                                if (updatedTask.description?.isNotEmpty ??
                                    false) ...[
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                            color: theme.textTheme.bodyMedium
                                                    ?.color ??
                                                Colors.black87,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                                const SizedBox(height: 60.0),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 12.0),
                                  child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Text(
                                      'Created at $createdDateFormatted | Time: $createdTimeFormatted',
                                      style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontSize: 16,
                                        color:
                                            theme.textTheme.bodySmall?.color ??
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
              ),
            ],
          ),
        ],
      ),
    );
  }
}
