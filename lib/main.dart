import 'package:appdev_proj/screens/lists_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/today_page.dart';
import 'screens/upcoming_page.dart';
import 'screens/calendar_page.dart';
import 'screens/settings_page.dart';
import 'screens/sticky_wall_page.dart';
import 'models/todo_model.dart';
import 'models/theme_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TodoModel()),
        ChangeNotifierProvider(create: (_) => ThemeModel()),
      ],
      child: Consumer<ThemeModel>(
        builder: (context, themeModel, child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'To-Do App',
          theme: themeModel.currentTheme,
          initialRoute: '/',
          routes: {
            '/': (context) => TodoHomePage(),
            '/today': (context) => TodayPage(),
            '/upcoming': (context) => UpcomingPage(),
            '/sticky-wall': (context) => StickyWallPage(),
            '/calendar': (context) => CalendarPage(),
            '/lists': (context) => ListPage(),
            '/settings': (context) => SettingsPage(),
          },
        ),
      ),
    );
  }
}

class TodoHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To-Do App'),
      ),
      drawer: AppDrawer(),
      body: const Center(
        child: Text('Home Page Content'),
      ),
    );
  }
}

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
              Navigator.pushNamed(context, '/sticky-wall');
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
