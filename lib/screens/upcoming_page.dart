import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:appdev_proj/models/todo_model.dart';
import 'package:appdev_proj/screens/add_task_page.dart';
import 'package:appdev_proj/screens/task_details_page.dart';
import 'package:appdev_proj/widgets/app_drawer.dart';

class UpcomingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'UPCOMING',
          style: TextStyle(
            color: isDarkMode
                ? const Color.fromARGB(255, 253, 199, 107)
                : const Color.fromARGB(255, 253, 199, 107),
            fontFamily: 'BebasNeue',
            fontSize: 25,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Color.fromARGB(255, 253, 199, 107),
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
              final description = task.description?.isNotEmpty ?? false
                  ? task.description
                  : 'No Description';

              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    side: const BorderSide(
                      color: Color.fromARGB(255, 253, 199, 107),
                      width: 2,
                    ),
                  ),
                  elevation: 8,
                  color: Colors.white,
                  shadowColor:
                      Color.fromARGB(255, 253, 199, 107).withOpacity(0.3),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 16.0),
                    title: Text(
                      task.title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: isDarkMode ? Colors.white : Colors.black87,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        decoration: task.completed
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          description ?? '',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: isDarkMode ? Colors.white70 : Colors.black54,
                            decoration: task.completed
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Due Date: ${DateFormat('MMMM dd, yyyy').format(task.dueDate)}',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: isDarkMode ? Colors.white70 : Colors.black54,
                          ),
                        ),
                      ],
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      color: Color.fromARGB(255, 253, 199, 107),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddTaskPage(),
            ),
          );
        },
        backgroundColor: theme.floatingActionButtonTheme.backgroundColor ??
            const Color.fromARGB(255, 253, 199, 107),
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
