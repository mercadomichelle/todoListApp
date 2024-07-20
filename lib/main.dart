import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/lists_page.dart';
import 'screens/today_page.dart';
import 'screens/upcoming_page.dart';
import 'screens/calendar_page.dart';
import 'screens/sticky_wall_page.dart';
import 'screens/intro_page.dart';
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
          initialRoute: '/intro',
          routes: {
            '/intro': (context) => FutureBuilder<bool>(
                  future: _isFirstLaunch(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return snapshot.data == true ? IntroPage() : ListPage();
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
            '/': (context) => IntroPage(),
            '/home': (context) => ListPage(),
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

  Future<bool> _isFirstLaunch() async {
    final prefs = await SharedPreferences.getInstance();
    final isFirstLaunch = prefs.getBool('isFirstLaunch') ?? true;
    if (isFirstLaunch) {
      await prefs.setBool('isFirstLaunch', false);
    }
    return isFirstLaunch;
  }
}
