import 'package:appdev_proj/models/theme_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var themeModel = Provider.of<ThemeModel>(context);
    final theme = Theme.of(context);
    final primaryColor = theme.primaryColor;
    final secondaryColor = theme.colorScheme.secondary;
    final onSurfaceColor = theme.colorScheme.onSurface;

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: primaryColor,
            ),
            child: Text(
              'Menu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.format_list_bulleted, color: secondaryColor),
            title: Text('All Task', style: TextStyle(color: onSurfaceColor)),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/all-task');
            },
          ),
          ListTile(
            leading: Icon(Icons.today, color: secondaryColor),
            title: Text('Today', style: TextStyle(color: onSurfaceColor)),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/today');
            },
          ),
          ListTile(
            leading: Icon(Icons.today, color: secondaryColor),
            title: Text('Upcoming', style: TextStyle(color: onSurfaceColor)),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/upcoming');
            },
          ),
          ListTile(
            leading: Icon(Icons.sticky_note_2, color: secondaryColor),
            title: Text('Sticky Wall', style: TextStyle(color: onSurfaceColor)),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/stickywall');
            },
          ),
          ListTile(
            leading: Icon(Icons.calendar_today, color: secondaryColor),
            title: Text('Calendar', style: TextStyle(color: onSurfaceColor)),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/calendar');
            },
          ),
          const Divider(),
          SwitchListTile(
            title: Text('Dark Mode', style: TextStyle(color: onSurfaceColor)),
            value: themeModel.isDarkMode,
            onChanged: (bool value) {
              themeModel.setDarkMode(value);
              Navigator.pop(context);
            },
            secondary: Icon(Icons.brightness_6, color: secondaryColor),
          ),
        ],
      ),
    );
  }
}
