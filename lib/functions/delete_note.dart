import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/todo_model.dart';

void deleteNoteDialog(BuildContext context, Task task) {
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
              const Text('Delete Note', style: TextStyle(fontFamily: 'Ubuntu')),
          content: const Text('Are you sure you want to delete this note?',
              style: TextStyle(fontFamily: 'Ubuntu')),
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
                Provider.of<TodoModel>(context, listen: false).removeTask(task);
                Navigator.of(context).pop();
              },
              child:
                  const Text('Delete', style: TextStyle(fontFamily: 'Ubuntu')),
            ),
          ],
        ),
      );
    },
  );
}
