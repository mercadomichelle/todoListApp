import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../models/todo_model.dart';
import 'package:appdev_proj/functions/add_note.dart';
import 'package:appdev_proj/functions/edit_note.dart';
import 'package:appdev_proj/functions/delete_note.dart';

class StickyWallPage extends StatefulWidget {
  @override
  _StickyWallPageState createState() => _StickyWallPageState();
}

class _StickyWallPageState extends State<StickyWallPage> {
  final List<Color> colors = [
    const Color(0xFFF7C04D),
    const Color(0xFFF6C1C0),
    const Color(0xFFA2DFF7),
    const Color(0xFFB0E57C),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    final backgroundImage =
        isDarkMode ? 'assets/images/bg3.jpg' : 'assets/images/bg1.jpg';
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
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              backgroundImage,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
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
                      onTap: () => editNoteDialog(context, task),
                      onLongPress: () => deleteNoteDialog(context, task),
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
                  staggeredTileBuilder: (int index) =>
                      const StaggeredTile.fit(2),
                  mainAxisSpacing: 8.0,
                  crossAxisSpacing: 8.0,
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => addNoteDialog(context),
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
