import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:appdev_proj/models/todo_model.dart';
import 'package:appdev_proj/screens/task_details_page.dart';
import 'package:appdev_proj/screens/add_task_page.dart';
import 'package:appdev_proj/widgets/app_drawer.dart';
import 'package:intl/intl.dart';

class ListPage extends StatelessWidget {
  static const routeName = '/list';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final yellowColor = const Color.fromARGB(255, 253, 199, 107);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'TASKS',
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
          if (model.isLoading) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(yellowColor),
              ),
            );
          }

          final List<Task> recentTasks = model.recentTasks;
          final List<Task> completedTasks = model.completedTasks;

          if (recentTasks.isEmpty && completedTasks.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/no_tasks2.png',
                    height: 200,
                    width: 200,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No tasks available.',
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

          return ListView(
            children: [
              if (recentTasks.isNotEmpty) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 16.0, horizontal: 16.0),
                  child: Text(
                    'Recent Tasks',
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: yellowColor,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                ),
                ...recentTasks.map((task) =>
                    _buildTaskCard(context, task, model, yellowColor)),
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
                ...completedTasks.map((task) =>
                    _buildTaskCard(context, task, model, yellowColor)),
              ],
            ],
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
        backgroundColor:
            theme.floatingActionButtonTheme.backgroundColor ?? yellowColor,
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildTaskCard(
      BuildContext context, Task task, TodoModel model, Color yellowColor) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
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
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
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
                task.description ?? 'No Description',
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
              const SizedBox(height: 6),
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
  }
}
