import 'package:appdev_proj/models/todo_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'add_task_page.dart';
import 'task_details_page.dart';

class StickyWallPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sticky Wall'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Consumer<TodoModel>(
        builder: (context, model, child) {
          return ListView.builder(
            itemCount: model.tasks.length,
            itemBuilder: (context, index) {
              final task = model.tasks[index];
              Color color = _getColor(index);

              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TaskDetailPage(task: task),
                      ),
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 4)],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(task.title,
                            style: Theme.of(context).textTheme.headlineMedium),
                        SizedBox(height: 8),
                        Text(task.description),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Color _getColor(int index) {
    final colors = [Colors.yellow, Colors.orange, Colors.red, Colors.blue];
    return colors[index % colors.length];
  }
}
