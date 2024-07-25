import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:appdev_proj/models/todo_model.dart';
import 'package:appdev_proj/screens/task_details_page.dart';
import 'package:appdev_proj/functions/add_task.dart';
import 'package:appdev_proj/widgets/app_drawer.dart';
import 'package:intl/intl.dart';

class TodayPage extends StatelessWidget {
  const TodayPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    const yellowColor = Color.fromARGB(255, 253, 199, 107);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'TODAY',
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
          final DateTime today = DateTime.now();
          final List<Task> todayTasks = model.tasks.where((task) {
            return !task.completed &&
                task.type != 'stickyNote' &&
                task.dueDate.year == today.year &&
                task.dueDate.month == today.month &&
                task.dueDate.day == today.day;
          }).toList();

          final List<Task> completedTasks = model.completedTasks.where((task) {
            return task.type != 'stickyNote' &&
                task.dueDate.year == today.year &&
                task.dueDate.month == today.month &&
                task.dueDate.day == today.day;
          }).toList();

          if (todayTasks.isEmpty && completedTasks.isEmpty) {
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

          return Stack(
            children: [
              if (todayTasks.isNotEmpty || completedTasks.isNotEmpty)
                Positioned.fill(
                  child: Image.asset(
                    isDarkMode
                        ? 'assets/images/bg2.jpg'
                        : 'assets/images/bg.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ListView(
                children: [
                  if (todayTasks.isNotEmpty) ...[
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 16.0),
                      child: Text(
                        'Today\'s Tasks',
                        style: theme.textTheme.titleLarge?.copyWith(
                          color: yellowColor,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                    ),
                    ...todayTasks.map((task) => _buildTaskCard(
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
              ),
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
                  fontSize: 20,
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
          trailing: Icon(
            Icons.arrow_forward_ios,
            color: priorityColor,
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
