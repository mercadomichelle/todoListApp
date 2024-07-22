import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:appdev_proj/models/todo_model.dart';
import 'package:appdev_proj/screens/task_details_page.dart';
import 'package:appdev_proj/screens/add_task_page.dart';
import 'package:appdev_proj/widgets/app_drawer.dart';
import 'package:intl/intl.dart';

class UpcomingPage extends StatelessWidget {
  const UpcomingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    const yellowColor = Color.fromARGB(255, 253, 199, 107);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'UPCOMING',
          style: TextStyle(
            color: yellowColor,
            fontFamily: 'BebasNeue',
            fontSize: 25,
          ),
        ),
        iconTheme: const IconThemeData(
          color: yellowColor,
        ),
      ),
      drawer: const AppDrawer(),
      body: Consumer<TodoModel>(
        builder: (context, model, child) {
          final DateTime now = DateTime.now();
          final List<Task> upcomingTasks = model.tasks.where((task) {
            return !task.completed && task.dueDate.isAfter(now);
          }).toList();

          final List<Task> completedTasks = model.completedTasks
              .where((task) => task.dueDate.isAfter(now))
              .toList();

          if (upcomingTasks.isEmpty && completedTasks.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/no_tasks1.png',
                    height: 200,
                    width: 200,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No upcoming tasks.',
                    style: theme.textTheme.titleLarge?.copyWith(
                        color: yellowColor,
                        fontFamily: 'Montserrat',
                        fontSize: 20,
                        fontStyle: FontStyle.italic),
                  ),
                ],
              ),
            );
          }

          return ListView(
            children: [
              if (upcomingTasks.isNotEmpty) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 16.0, horizontal: 16.0),
                  child: Text(
                    'Upcoming Tasks',
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: yellowColor,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                ),
                ...upcomingTasks.map((task) => _buildTaskCard(
                    context, task, model, yellowColor, isDarkMode)),
              ],
              if (completedTasks.isNotEmpty) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 16.0, horizontal: 16.0),
                  child: Text(
                    'Completed Tasks',
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: yellowColor,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                ),
                ...completedTasks.map((task) => _buildTaskCard(
                    context, task, model, yellowColor, isDarkMode)),
              ],
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) => const AddTaskPage(),
          );
        },
        backgroundColor: yellowColor,
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildTaskCard(BuildContext context, Task task, TodoModel model,
      Color yellowColor, bool isDarkMode) {
    Color priorityColor;
    switch (task.priority) {
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

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: BorderSide(
            color: priorityColor,
            width: 2,
          ),
        ),
        elevation: 8,
        color: isDarkMode ? Colors.black : Colors.white,
        shadowColor: priorityColor.withOpacity(0.3),
        child: ListTile(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
          leading: Checkbox(
            value: task.completed,
            onChanged: (bool? value) {
              if (value != null) {
                model.updateTaskCompletion(task, value);
              }
            },
            activeColor: priorityColor,
            checkColor: Colors.black,
          ),
          title: Text(
            task.title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
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
                task.description ?? 'No Description',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
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
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: isDarkMode ? Colors.white70 : Colors.black54,
                      fontFamily: 'Ubuntu',
                      decoration: task.completed
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
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
  }
}
