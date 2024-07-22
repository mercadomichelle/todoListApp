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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final bool showIntro = await MyApp._isFirstLaunch();

  // Initialize TodoModel and fetch tasks
  final todoModel = TodoModel();
  await todoModel.fetchTasks();

  runApp(MyApp(showIntro: showIntro, todoModel: todoModel));
}

class MyApp extends StatelessWidget {
  final bool showIntro;
  final TodoModel todoModel;

  const MyApp({super.key, required this.showIntro, required this.todoModel});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => todoModel),
        ChangeNotifierProvider(create: (_) => ThemeModel()),
      ],
      child: Consumer<ThemeModel>(
        builder: (context, themeModel, child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'To-Do App',
          theme: themeModel.currentTheme,
          home: showIntro ? const IntroPage() : const ListPage(),
          routes: {
            '/home': (context) => const ListPage(),
            '/today': (context) => const TodayPage(),
            '/upcoming': (context) => const UpcomingPage(),
            '/stickywall': (context) => StickyWallPage(),
            '/calendar': (context) => const CalendarPage(),
          },
        ),
      ),
    );
  }

  static Future<bool> _isFirstLaunch() async {
    final prefs = await SharedPreferences.getInstance();
    final isFirstLaunch = prefs.getBool('isFirstLaunch') ?? true;
    if (isFirstLaunch) {
      await prefs.setBool('isFirstLaunch', false);
    }
    return isFirstLaunch;
  }
}
