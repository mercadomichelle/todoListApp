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
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    final yellowColor = const Color.fromARGB(255, 253, 199, 107);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'TODAY',
          style: TextStyle(
            color: yellowColor,
            fontFamily: 'BebasNeue',
            fontSize: 25,
          ),
        ),
        iconTheme: IconThemeData(
          color: yellowColor,
        ),
      ),
      drawer: AppDrawer(),
      body: Consumer<TodoModel>(
        builder: (context, model, child) {
          final List<Task> todayTasks = model.tasks.where((task) {
            return task.dueDate.year == DateTime.now().year &&
                task.dueDate.month == DateTime.now().month &&
                task.dueDate.day == DateTime.now().day;
          }).toList();

          if (todayTasks.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/no_tasks.png',
                    height: 200,
                    width: 200,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No tasks for today.',
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: yellowColor,
                      fontFamily: 'Montserrat',
                      fontSize: 20,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            itemCount: todayTasks.length,
            itemBuilder: (context, index) {
              final task = todayTasks[index];
              final description = task.description?.isNotEmpty ?? false
                  ? task.description
                  : 'No Description';

              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    side: BorderSide(
                      color: yellowColor,
                      width: 2,
                    ),
                  ),
                  elevation: 8,
                  color: isDarkMode ? Colors.black : Colors.white,
                  shadowColor: yellowColor.withOpacity(0.3),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 16.0),
                    leading: Checkbox(
                      value: task.completed,
                      onChanged: (bool? value) {
                        if (value != null) {
                          model.updateTaskCompletion(task, value);
                        }
                      },
                      activeColor: yellowColor,
                      checkColor: Colors.black,
                    ),
                    title: Text(
                      task.title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: isDarkMode ? Colors.white : Colors.black87,
                        fontFamily: 'Ubuntu',
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
                            fontFamily: 'Ubuntu',
                            decoration: task.completed
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Due Date: ${DateFormat('MMMM dd, yyyy').format(task.dueDate)}',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: isDarkMode ? Colors.white70 : Colors.black54,
                            fontFamily: 'Ubuntu',
                            decoration: task.completed
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                          ),
                        ),
                      ],
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: yellowColor,
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
          showDialog(
            context: context,
            builder: (BuildContext context) => AddTaskPage(),
          );
        },
        backgroundColor: yellowColor,
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
