import 'package:flutter/foundation.dart';

class TodoModel extends ChangeNotifier {
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

  void updateTask(Task task, Task updatedTask) {}
}

class Task {
  final String title;
  final String description;
  final DateTime dueDate;

  Task({required this.title, required this.description, required this.dueDate});
}
