import 'package:appdev_proj/models/theme_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var themeModel = Provider.of<ThemeModel>(context);

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
          SwitchListTile(
            title: const Text('Dark Mode'),
            value: themeModel.isDarkMode,
            onChanged: (bool value) {
              themeModel.setDarkMode(value);
              Navigator.pop(context);
            },
            secondary: const Icon(Icons.brightness_6),
          ),
        ],
      ),
    );
  }
}
