import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:appdev_proj/models/todo_model.dart';

class EditTaskPage extends StatefulWidget {
  final Task task;

  EditTaskPage({required this.task});

  @override
  _EditTaskPageState createState() => _EditTaskPageState();
}

class _EditTaskPageState extends State<EditTaskPage> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  late DateTime _dueDate;
  late bool _isDone;

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.task.title;
    _descriptionController.text = widget.task.description;
    _dueDate = widget.task.dueDate;
    _isDone = widget.task.isDone;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.primaryColor;
    final secondaryColor = theme.colorScheme.secondary;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Task'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Title',
              style: TextStyle(
                color: primaryColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Enter task title',
                labelStyle: TextStyle(color: primaryColor),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: primaryColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: secondaryColor),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Description',
              style: TextStyle(
                color: primaryColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: 'Enter task description',
                labelStyle: TextStyle(color: primaryColor),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: primaryColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: secondaryColor),
                ),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final pickedDate = await showDatePicker(
                  context: context,
                  initialDate: _dueDate,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101),
                  builder: (context, child) {
                    return Theme(
                      data: theme.copyWith(
                        colorScheme: ColorScheme.light(
                          primary: primaryColor,
                          onPrimary: Colors.white,
                          onSurface: primaryColor,
                        ),
                      ),
                      child: child!,
                    );
                  },
                );
                if (pickedDate != null && pickedDate != _dueDate) {
                  setState(() {
                    _dueDate = pickedDate;
                  });
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text('Pick Due Date'),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (_titleController.text.isNotEmpty &&
                      _descriptionController.text.isNotEmpty) {
                    final updatedTask = Task(
                      id: widget.task.id,
                      title: _titleController.text,
                      description: _descriptionController.text,
                      dueDate: _dueDate,
                      isDone: _isDone,
                    );
                    Provider.of<TodoModel>(context, listen: false)
                        .updateTask(widget.task, updatedTask);
                    Navigator.pop(context, updatedTask);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: secondaryColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  child: Text('Save Changes'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
