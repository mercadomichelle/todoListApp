import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:appdev_proj/models/todo_model.dart';
import 'package:appdev_proj/screens/task_details_page.dart';
import 'package:appdev_proj/screens/add_task_page.dart';
import 'package:appdev_proj/widgets/app_drawer.dart';
import 'package:intl/intl.dart';

class ListPage extends StatelessWidget {
  static const Color cardColor = Color.fromARGB(255, 253, 199, 107);

  const ListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'TO DO LIST',
          style: TextStyle(
            color: cardColor,
            fontFamily: 'BebasNeue',
            fontSize: 25,
          ),
        ),
        iconTheme: const IconThemeData(
          color: cardColor,
        ),
      ),
      drawer: AppDrawer(),
      body: Container(
        color: theme.scaffoldBackgroundColor,
        child: Consumer<TodoModel>(
          builder: (context, model, child) {
            final List<Task> allTasks = model.tasks;

            return ListView.builder(
              itemCount: allTasks.length,
              itemBuilder: (context, index) {
                final task = allTasks[index];
                final dueDateFormatted =
                    DateFormat('MMMM dd, yyyy').format(task.dueDate);

                return Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                      side: const BorderSide(
                        color: cardColor,
                        width: 2,
                      ),
                    ),
                    elevation: 8,
                    color: Colors.white,
                    shadowColor: cardColor.withOpacity(0.3),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 16.0),
                      leading: Theme(
                        data: ThemeData(
                          checkboxTheme: CheckboxThemeData(
                            checkColor: WidgetStateProperty.all(Colors.white),
                            fillColor: WidgetStateProperty.all(cardColor),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                        child: Checkbox(
                          value: task.completed,
                          onChanged: (bool? value) {
                            model.updateTaskCompletion(task, value ?? false);
                          },
                        ),
                      ),
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
                      subtitle: Text(
                        '${task.description?.isNotEmpty ?? false ? task.description : 'No Description'}\nDue Date: $dueDateFormatted',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: isDarkMode ? Colors.white70 : Colors.black54,
                          decoration: task.completed
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2, // Adjust the number of lines as needed
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        color: cardColor,
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) => AddTaskPage(),
          );
        },
        backgroundColor: cardColor,
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
