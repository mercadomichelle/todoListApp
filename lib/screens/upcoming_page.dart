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

              return ListTile(
                title: Text(task.title),
                subtitle: Text(
                    '$description\nDue Date: ${DateFormat('MMMM dd, yyyy').format(task.dueDate)}'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TaskDetailPage(task: task),
                    ),
                  );
                },
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
