import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:appdev_proj/models/todo_model.dart';
// import 'package:appdev_proj/models/task.dart';

class DeleteTaskDialog {
  static void show(BuildContext context, Task task) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Theme(
          data: ThemeData.light().copyWith(
            dialogBackgroundColor: const Color.fromARGB(255, 255, 238, 205),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(foregroundColor: Colors.black),
            ),
          ),
          child: AlertDialog(
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
                  Provider.of<TodoModel>(context, listen: false)
                      .removeTask(task);
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
                child: const Text('Delete'),
              ),
            ],
          ),
        );
      },
    );
  }
}
