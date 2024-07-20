import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/theme_model.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 255, 216, 148),
            ),
            child: Text(
              'Menu',
              style: TextStyle(
                color: Color.fromARGB(255, 0, 0, 0),
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.format_list_bulleted),
            title: const Text('All Task'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/all-task');
            },
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
          const Divider(),
          Consumer<ThemeModel>(
            builder: (context, themeModel, child) {
              return SwitchListTile(
                title: const Text('Dark Mode'),
                value: themeModel.isDarkMode,
                onChanged: (value) {
                  themeModel.setDarkMode(value);
                },
                secondary: const Icon(Icons.dark_mode),
              );
            },
          ),
        ],
      ),
    );
  }
}
