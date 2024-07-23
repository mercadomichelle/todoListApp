import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/todo_model.dart';

void addNoteDialog(BuildContext context) {
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
          title: const Text('Add Note', style: TextStyle(fontFamily: 'Ubuntu')),
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
                    type: 'stickyNote',
                  );
                  Provider.of<TodoModel>(context, listen: false).addTask(task);
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Add', style: TextStyle(fontFamily: 'Ubuntu')),
            ),
          ],
        ),
      );
    },
  );
}
