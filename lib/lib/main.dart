import 'package:appdev_proj/screens/lists_page.dart';
import 'package:appdev_proj/widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/today_page.dart';
import 'screens/upcoming_page.dart';
import 'screens/calendar_page.dart';
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
            '/': (context) => ListPage(),
            '/all-task': (context) => ListPage(),
            '/today': (context) => TodayPage(),
            '/upcoming': (context) => UpcomingPage(),
            '/stickywall': (context) => StickyWallPage(),
            '/calendar': (context) => CalendarPage(),
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
