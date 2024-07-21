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
  bool _isLoading = false;

  List<Task> get tasks => _tasks;
  bool get isLoading => _isLoading;

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
    final index = _tasks.indexWhere((t) => t.id == task.id);
    if (index != -1) {
      _tasks[index].completed = completed;
      notifyListeners();
    }
  }

  List<Task> get recentTasks {
    return _tasks.where((task) => !task.completed).toList();
  }

  List<Task> get completedTasks {
    return _tasks.where((task) => task.completed).toList();
  }

  Future<void> fetchTasks() async {
    _isLoading = true;
    notifyListeners();

    try {
      await Future.delayed(const Duration(seconds: 2));
    } catch (error) {
      if (kDebugMode) {
        print('Error fetching tasks: $error');
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
