import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:appdev_proj/models/todo_model.dart';
import 'package:appdev_proj/screens/task_details_page.dart';
import 'package:appdev_proj/screens/add_task_page.dart';
import 'package:appdev_proj/widgets/app_drawer.dart';
import 'package:intl/intl.dart';

class TodayPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Today'),
      ),
      drawer: AppDrawer(),
      body: Consumer<TodoModel>(
        builder: (context, model, child) {
          final List<Task> todayTasks = model.tasks.where((task) {
            return task.dueDate.year == DateTime.now().year &&
                task.dueDate.month == DateTime.now().month &&
                task.dueDate.day == DateTime.now().day;
          }).toList();

          return ListView.builder(
            itemCount: todayTasks.length,
            itemBuilder: (context, index) {
              final task = todayTasks[index];
              final description = task.description?.isNotEmpty ?? false
                  ? task.description
                  : 'No Description';

              return ListTile(
                title: Text(task.title),
                subtitle: Text(
                    '$description\nDue Date: ${DateFormat('MMMM dd, yyyy').format(task.dueDate)}'),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
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
