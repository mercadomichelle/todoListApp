import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Menu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.today),
            title: const Text('Today'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/today');
            },
          ),
          ListTile(
            leading: const Icon(Icons.today),
            title: const Text('Upcoming'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/upcoming');
            },
          ),
          ListTile(
            leading: const Icon(Icons.sticky_note_2),
            title: const Text('Sticky Wall'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/stickywall');
            },
          ),
          ListTile(
            leading: const Icon(Icons.calendar_today),
            title: const Text('Calendar'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/calendar');
            },
          ),
          ListTile(
            leading: const Icon(Icons.format_list_bulleted),
            title: const Text('Lists'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/lists');
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/settings');
            },
          ),
        ],
      ),
    );
  }
}
