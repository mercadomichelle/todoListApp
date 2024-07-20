import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';

class StickyWallPage extends StatefulWidget {
  @override
  _StickyWallPageState createState() => _StickyWallPageState();
}

class _StickyWallPageState extends State<StickyWallPage> {
  final List<Map<String, String>> notes = [];
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
        String content = '';
        final _formKey = GlobalKey<FormState>();

        return AlertDialog(
          title: const Text('Add Note'),
          content: Form(
            key: _formKey,
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
                ),
                TextFormField(
                  onChanged: (value) {
                    content = value;
                  },
                  decoration: const InputDecoration(labelText: 'Description'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter description';
                    }
                    return null;
                  },
                ),
              ],
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
                if (_formKey.currentState!.validate()) {
                  String timestamp =
                      DateFormat('EEE MMM dd kk:mm').format(DateTime.now());
                  setState(() {
                    notes.add({
                      'title': title,
                      'content': content,
                      'timestamp': timestamp,
                    });
                  });
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _editNote(int index) {
    String title = notes[index]['title']!;
    String content = notes[index]['content']!;
    final _formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Note'),
          content: Form(
            key: _formKey,
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
                ),
                TextFormField(
                  initialValue: content,
                  onChanged: (value) {
                    content = value;
                  },
                  decoration: const InputDecoration(labelText: 'Description'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter description';
                    }
                    return null;
                  },
                ),
              ],
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
                if (_formKey.currentState!.validate()) {
                  String timestamp =
                      DateFormat('EEE MMM dd kk:mm').format(DateTime.now());
                  setState(() {
                    notes[index] = {
                      'title': title,
                      'content': content,
                      'timestamp': timestamp,
                    };
                  });
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _deleteNote(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Note'),
          content: const Text('Are you sure you want to delete this note?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  notes.removeAt(index);
                });
                Navigator.of(context).pop();
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sticky Wall'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StaggeredGridView.countBuilder(
          crossAxisCount: 4,
          itemCount: notes.length,
          itemBuilder: (BuildContext context, int index) => GestureDetector(
            onTap: () => _editNote(index),
            onLongPress: () => _deleteNote(index),
            child: NoteTile(
              title: notes[index]['title']!,
              content: notes[index]['content']!,
              timestamp: notes[index]['timestamp']!,
              color: colors[index % colors.length],
            ),
          ),
          staggeredTileBuilder: (int index) => StaggeredTile.fit(2),
          mainAxisSpacing: 8.0,
          crossAxisSpacing: 8.0,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNote,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class NoteTile extends StatelessWidget {
  final String title;
  final String content;
  final String timestamp;
  final Color color;

  NoteTile({
    required this.title,
    required this.content,
    required this.timestamp,
    required this.color,
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
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.bottomRight,
            child: Text(
              timestamp,
              style: TextStyle(
                fontSize: 12,
                color: Colors.white70,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
