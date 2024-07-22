import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'dueDate': dueDate.toIso8601String(),
      'creationDate': creationDate.toIso8601String(),
      'completed': completed,
    };
  }

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      dueDate: DateTime.parse(json['dueDate']),
      creationDate: DateTime.parse(json['creationDate']),
      completed: json['completed'],
    );
  }
}

class TodoModel extends ChangeNotifier {
  final List<Task> _tasks = [];
  bool _isLoading = false;

  List<Task> get tasks => _tasks;
  bool get isLoading => _isLoading;

  void addTask(Task task) {
    _tasks.add(task);
    saveTasks();
    notifyListeners();
  }

  void removeTask(Task task) {
    _tasks.remove(task);
    saveTasks();
    notifyListeners();
  }

  void updateTask(Task oldTask, Task newTask) {
    final index = _tasks.indexWhere((task) => task.id == oldTask.id);
    if (index != -1) {
      _tasks[index] = newTask;
      saveTasks();
      notifyListeners();
    }
  }

  void updateTaskCompletion(Task task, bool completed) {
    final index = _tasks.indexWhere((t) => t.id == task.id);
    if (index != -1) {
      _tasks[index].completed = completed;
      saveTasks();
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
      await loadTasks();
    } catch (error) {
      if (kDebugMode) {
        print('Error fetching tasks: $error');
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> saveTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> taskJsonList =
        _tasks.map((task) => jsonEncode(task.toJson())).toList();
    await prefs.setStringList('tasks', taskJsonList);
  }

  Future<void> loadTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? taskJsonList = prefs.getStringList('tasks');
    if (taskJsonList != null) {
      _tasks.clear();
      _tasks.addAll(
        taskJsonList.map((taskJson) => Task.fromJson(jsonDecode(taskJson))),
      );
    }
  }
}
