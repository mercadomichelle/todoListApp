import 'package:flutter/material.dart';

class Task {
  String title;
  String description;
  DateTime dueDate;

  Task({required this.title, required this.description, required this.dueDate});
}

class TodoModel with ChangeNotifier {
  List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  void addTask(Task task) {
    _tasks.add(task);
    notifyListeners();
  }

  void removeTask(Task task) {
    _tasks.remove(task);
    notifyListeners();
  }
}
