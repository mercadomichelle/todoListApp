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
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Tasks'),
      ),
      drawer: AppDrawer(),
      body: Consumer<TodoModel>(
        builder: (context, model, child) {
          final List<Task> allTasks = model.tasks;

          return ListView.builder(
            itemCount: allTasks.length,
            itemBuilder: (context, index) {
              final task = allTasks[index];
              final dueDateFormatted =
                  DateFormat('MMMM dd, yyyy').format(task.dueDate);

              return ListTile(
                title: Text(task.title),
                subtitle:
                    Text('${task.description}\nDue Date: $dueDateFormatted'),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    model.removeTask(task);
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
}
