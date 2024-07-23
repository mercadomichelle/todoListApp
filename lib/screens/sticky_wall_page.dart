import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../models/todo_model.dart';

class StickyWallPage extends StatefulWidget {
  @override
  _StickyWallPageState createState() => _StickyWallPageState();
}

class _StickyWallPageState extends State<StickyWallPage> {
  final List<Color> colors = [
    Colors.yellow,
    Colors.pink,
    Colors.blue,
    Colors.green,
  ];

  void _addNote() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String title = '';
        String? content;
        final formKey = GlobalKey<FormState>();

        return Theme(
          data: ThemeData.light().copyWith(
            dialogBackgroundColor: const Color.fromARGB(255, 250, 205, 126),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.black,
              ),
            ),
            textTheme: const TextTheme(
              titleLarge: TextStyle(
                fontFamily: 'Ubuntu',
              ),
              labelLarge: TextStyle(
                fontFamily: 'Ubuntu',
              ),
            ),
          ),
          child: AlertDialog(
            title:
                const Text('Add Note', style: TextStyle(fontFamily: 'Ubuntu')),
            content: Container(
              constraints: const BoxConstraints(
                minWidth: 300,
                maxWidth: 300,
              ),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextFormField(
                      onChanged: (value) {
                        title = value;
                      },
                      decoration: const InputDecoration(labelText: 'Title'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a title';
                        }
                        return null;
                      },
                      style: const TextStyle(fontFamily: 'Ubuntu'),
                    ),
                    TextFormField(
                      onChanged: (value) {
                        content = value;
                      },
                      decoration:
                          const InputDecoration(labelText: 'Description'),
                      validator: (value) {
                        return null;
                      },
                      style: const TextStyle(fontFamily: 'Ubuntu'),
                    ),
                  ],
                ),
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    final task = Task(
                      id: DateTime.now().toString(),
                      title: title,
                      description: content,
                      dueDate: DateTime.now(),
                      creationDate: DateTime.now(),
                      type: 'stickyNote', // Set type to stickyNote
                    );
                    Provider.of<TodoModel>(context, listen: false)
                        .addTask(task);
                    Navigator.of(context).pop();
                  }
                },
                child:
                    const Text('Add', style: TextStyle(fontFamily: 'Ubuntu')),
              ),
            ],
          ),
        );
      },
    );
  }

  void _editNote(Task task) {
    String title = task.title;
    String? content = task.description;
    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Theme(
          data: ThemeData.light().copyWith(
            dialogBackgroundColor: const Color.fromARGB(255, 250, 205, 126),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.black,
              ),
            ),
            textTheme: const TextTheme(
              titleLarge: TextStyle(
                fontFamily: 'Ubuntu',
              ),
              labelLarge: TextStyle(
                fontFamily: 'Ubuntu',
              ),
            ),
          ),
          child: AlertDialog(
            title:
                const Text('Edit Note', style: TextStyle(fontFamily: 'Ubuntu')),
            content: Container(
              constraints: const BoxConstraints(
                minWidth: 300,
                maxWidth: 300,
              ),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextFormField(
                      initialValue: title,
                      onChanged: (value) {
                        title = value;
                      },
                      decoration: const InputDecoration(labelText: 'Title'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a title';
                        }
                        return null;
                      },
                      style: const TextStyle(fontFamily: 'Ubuntu'),
                    ),
                    TextFormField(
                      initialValue: content,
                      onChanged: (value) {
                        content = value;
                      },
                      decoration:
                          const InputDecoration(labelText: 'Description'),
                      validator: (value) {
                        return null;
                      },
                      style: const TextStyle(fontFamily: 'Ubuntu'),
                    ),
                  ],
                ),
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel',
                    style: TextStyle(fontFamily: 'Ubuntu')),
              ),
              TextButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    final newTask = Task(
                      id: task.id,
                      title: title,
                      description: content,
                      dueDate: task.dueDate,
                      creationDate: task.creationDate,
                      completed: task.completed,
                      type: 'stickyNote', // Set type to stickyNote
                    );
                    Provider.of<TodoModel>(context, listen: false)
                        .updateTask(task, newTask);
                    Navigator.of(context).pop();
                  }
                },
                child:
                    const Text('Save', style: TextStyle(fontFamily: 'Ubuntu')),
              ),
            ],
          ),
        );
      },
    );
  }

  void _deleteNote(Task task) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Theme(
          data: ThemeData.light().copyWith(
            dialogBackgroundColor: const Color.fromARGB(255, 250, 205, 126),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.black,
              ),
            ),
            textTheme: const TextTheme(
              titleLarge: TextStyle(
                fontFamily: 'Ubuntu',
              ),
              labelLarge: TextStyle(
                fontFamily: 'Ubuntu',
              ),
            ),
          ),
          child: AlertDialog(
            title: const Text('Delete Note',
                style: TextStyle(fontFamily: 'Ubuntu')),
            content: const Text('Are you sure you want to delete this note?',
                style: TextStyle(fontFamily: 'Ubuntu')),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel',
                    style: TextStyle(fontFamily: 'Ubuntu')),
              ),
              TextButton(
                onPressed: () {
                  Provider.of<TodoModel>(context, listen: false)
                      .removeTask(task);
                  Navigator.of(context).pop();
                },
                child: const Text('Delete',
                    style: TextStyle(fontFamily: 'Ubuntu')),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    final backgroundColor =
        isDarkMode ? Colors.black : const Color.fromARGB(255, 245, 245, 245);
    final textColor = isDarkMode ? Colors.black : Colors.black;
    const yellowColor = Color.fromARGB(255, 253, 199, 107);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text(
          'STICKY NOTE',
          style: TextStyle(
            color: Color.fromARGB(255, 253, 199, 107),
            fontFamily: 'BebasNeue',
            fontSize: 25,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Color.fromARGB(255, 253, 199, 107),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<TodoModel>(
          builder: (context, todoModel, child) {
            final stickyNotes = todoModel.tasks
                .where((task) => task.type == 'stickyNote')
                .toList();
            return StaggeredGridView.countBuilder(
              crossAxisCount: 4,
              itemCount: stickyNotes.length,
              itemBuilder: (BuildContext context, int index) {
                final task = stickyNotes[index];
                return GestureDetector(
                  onTap: () => _editNote(task),
                  onLongPress: () => _deleteNote(task),
                  child: NoteTile(
                    title: task.title,
                    content: task.description,
                    timestamp: DateFormat('EEE MMM dd kk:mm')
                        .format(task.creationDate),
                    color: colors[index % colors.length],
                    textColor: textColor,
                  ),
                );
              },
              staggeredTileBuilder: (int index) => const StaggeredTile.fit(2),
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNote,
        backgroundColor:
            theme.floatingActionButtonTheme.backgroundColor ?? yellowColor,
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class NoteTile extends StatelessWidget {
  final String title;
  final String? content;
  final String timestamp;
  final Color color;
  final Color textColor;

  const NoteTile({
    super.key,
    required this.title,
    this.content,
    required this.timestamp,
    required this.color,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8.0),
      ),
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: textColor,
              fontFamily: 'Ubuntu',
            ),
          ),
          if (content != null && content!.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(
              content!,
              style: TextStyle(
                fontSize: 16,
                color: textColor.withOpacity(0.87),
                fontFamily: 'Ubuntu',
              ),
            ),
          ],
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.bottomRight,
            child: Text(
              timestamp,
              style: TextStyle(
                fontSize: 12,
                color: textColor.withOpacity(0.54),
                fontFamily: 'Ubuntu',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
