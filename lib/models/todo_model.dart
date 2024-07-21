import 'package:flutter/foundation.dart';

class Task {
  final String id;
  String title;
  final String? description;
  DateTime dueDate;
  final DateTime creationDate;
  bool completed;

  Task({
    required this.id,
    required this.title,
    this.description,
    required this.dueDate,
    required this.creationDate,
    this.completed = false,
  });
}

class TodoModel extends ChangeNotifier {
  final List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  void addTask(Task task) {
    _tasks.add(task);
    notifyListeners();
  }

  void removeTask(Task task) {
    _tasks.remove(task);
    notifyListeners();
  }

  void updateTask(Task oldTask, Task newTask) {
    final index = _tasks.indexWhere((task) => task.id == oldTask.id);
    if (index != -1) {
      _tasks[index] = newTask;
      notifyListeners();
    }
  }

  void updateTaskCompletion(Task task, bool completed) {
    task.completed = completed;
    notifyListeners();
  }
}
