import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/theme_model.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 255, 216, 148),
                  Color.fromARGB(255, 255, 200, 100),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Row(
              children: [
                Text(
                  'Menu',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'BebasNeue',
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                ListTile(
                  leading: const Icon(Icons.format_list_bulleted,
                      color: Color.fromARGB(255, 250, 183, 66)),
                  title: const Text(
                    'All Task',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/all-task');
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.today,
                      color: Color.fromARGB(255, 250, 183, 66)),
                  title: const Text(
                    'Today',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/today');
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.schedule,
                      color: Color.fromARGB(255, 250, 183, 66)),
                  title: const Text(
                    'Upcoming',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/upcoming');
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.sticky_note_2,
                      color: Color.fromARGB(255, 250, 183, 66)),
                  title: const Text(
                    'Sticky Wall',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/stickywall');
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.calendar_today,
                      color: Color.fromARGB(255, 250, 183, 66)),
                  title: const Text(
                    'Calendar',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/calendar');
                  },
                ),
                const Divider(),
                Consumer<ThemeModel>(
                  builder: (context, themeModel, child) {
                    return SwitchListTile(
                      title: const Text(
                        'Dark Mode',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                        ),
                      ),
                      value: themeModel.isDarkMode,
                      onChanged: (value) {
                        themeModel.setDarkMode(value);
                      },
                      secondary: Icon(
                        themeModel.isDarkMode
                            ? Icons.dark_mode
                            : Icons.light_mode,
                        color: const Color.fromARGB(255, 250, 183, 66),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
