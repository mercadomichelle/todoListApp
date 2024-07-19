import 'package:appdev_proj/widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:appdev_proj/models/todo_model.dart';
import 'package:appdev_proj/screens/add_task_page.dart';
import 'package:appdev_proj/screens/task_details_page.dart';

class UpcomingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upcoming'),
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
              return ListTile(
                title: Text(task.title),
                subtitle: Text(task.description),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
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
        child: Icon(Icons.add),
      ),
    );
  }
}
