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

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.task.title;
    _descriptionController.text = widget.task.description;
    _dueDate = widget.task.dueDate;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final pickedDate = await showDatePicker(
                  context: context,
                  initialDate: _dueDate,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101),
                );
                if (pickedDate != null && pickedDate != _dueDate) {
                  setState(() {
                    _dueDate = pickedDate;
                  });
                }
              },
              child: Text('Pick Due Date: ${_dueDate.toLocal()}'.split(' ')[0]),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_titleController.text.isNotEmpty &&
                    _descriptionController.text.isNotEmpty) {
                  final updatedTask = Task(
                    id: widget.task.id,
                    title: _titleController.text,
                    description: _descriptionController.text,
                    dueDate: _dueDate,
                  );
                  Provider.of<TodoModel>(context, listen: false)
                      .updateTask(widget.task, updatedTask);
                  Navigator.pop(context, updatedTask);
                }
              },
              child: const Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}
