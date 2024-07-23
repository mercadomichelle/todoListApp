import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/todo_model.dart';

void editNoteDialog(BuildContext context, Task task) {
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
                    decoration: const InputDecoration(labelText: 'Description'),
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
              child:
                  const Text('Cancel', style: TextStyle(fontFamily: 'Ubuntu')),
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
                    type: 'stickyNote',
                  );
                  Provider.of<TodoModel>(context, listen: false)
                      .updateTask(task, newTask);
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Save', style: TextStyle(fontFamily: 'Ubuntu')),
            ),
          ],
        ),
      );
    },
  );
}
