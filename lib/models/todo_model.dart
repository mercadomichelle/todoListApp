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
  int priority;
  final String type; // New field to specify the type of task

  Task({
    required this.id,
    required this.title,
    this.description,
    required this.dueDate,
    required this.creationDate,
    this.completed = false,
    this.priority = 1,
    this.type = 'generalTask', // Default type
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'dueDate': dueDate.toIso8601String(),
      'creationDate': creationDate.toIso8601String(),
      'completed': completed,
      'priority': priority,
      'type': type, // Include type in JSON serialization
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
      priority: json['priority'] ?? 1,
      type: json['type'] ?? 'generalTask', // Default type
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Task && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}

class TodoModel extends ChangeNotifier {
  final List<Task> _tasks = [];
  bool _isLoading = false;

  List<Task> get tasks => _tasks;
  bool get isLoading => _isLoading;

  void addTask(Task task) {
    _tasks.add(task);
    _sortTasksByPriority();
    saveTasks();
    notifyListeners();
  }

  void removeTask(Task task) {
    _tasks.remove(task);
    _sortTasksByPriority();
    saveTasks();
    notifyListeners();
  }

  void updateTask(Task oldTask, Task newTask) {
    final index = _tasks.indexWhere((task) => task.id == oldTask.id);
    if (index != -1) {
      _tasks[index] = newTask;
      _sortTasksByPriority();
      saveTasks();
      notifyListeners();
    }
  }

  void updateTaskCompletion(Task task, bool completed) {
    final index = _tasks.indexOf(task);
    if (index != -1) {
      _tasks[index] = Task(
        id: task.id,
        title: task.title,
        description: task.description,
        dueDate: task.dueDate,
        creationDate: task.creationDate,
        completed: completed,
        priority: task.priority,
        type: task.type,
      );
      notifyListeners();
    }
  }

  void _sortTasksByPriority() {
    _tasks.sort((a, b) => b.priority.compareTo(a.priority));
  }

// New method to differentiate task types
  void addStickyNoteTask(Task task) {
    if (task.type == 'stickyNote') {
      _tasks.add(task);
      _sortTasksByPriority();
      saveTasks();
      notifyListeners();
    }
  }

  List<Task> get recentTasks {
    return _tasks
        .where((task) => !task.completed && task.type == 'generalTask')
        .toList()
      ..sort((a, b) => b.creationDate.compareTo(a.creationDate));
  }

  List<Task> get completedTasks {
    return _tasks.where((task) => task.completed).toList();
  }

  List<Task> get stickyNotes {
    return _tasks.where((task) => task.type == 'stickyNote').toList();
  }

  List<Task> get generalTasks {
    return _tasks.where((task) => task.type == 'generalTask').toList();
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
