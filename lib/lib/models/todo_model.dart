import 'package:flutter/material.dart';

class Task {
  String id;
  String title;
  String description;
  DateTime dueDate;
  bool isDone;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.dueDate,
    this.isDone = false,
  });
}

class TodoModel extends ChangeNotifier {
  List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  void addTask(Task task) {
    _tasks.add(task);
    notifyListeners();
  }

  void updateTask(Task oldTask, Task newTask) {
    final taskIndex = _tasks.indexOf(oldTask);
    if (taskIndex >= 0) {
      _tasks[taskIndex] = newTask;
      notifyListeners();
    }
  }

  void removeTask(Task task) {
    _tasks.remove(task);
    notifyListeners();
  }
}
