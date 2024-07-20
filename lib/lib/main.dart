import 'package:appdev_proj/screens/lists_page.dart';
import 'package:appdev_proj/screens/today_page.dart';
import 'package:appdev_proj/screens/upcoming_page.dart';
import 'package:appdev_proj/screens/calendar_page.dart';
import 'package:appdev_proj/screens/sticky_wall_page.dart';
import 'package:appdev_proj/models/todo_model.dart';
import 'package:appdev_proj/models/theme_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
