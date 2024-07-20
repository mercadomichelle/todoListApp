import 'package:flutter/material.dart';
import 'package:appdev_proj/widgets/app_drawer.dart';

class TodoHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.primaryColor;

    return Scaffold(
      appBar: AppBar(
        title: const Text('To-Do App'),
        backgroundColor: primaryColor,
      ),
      drawer: AppDrawer(),
      body: const Center(
        child: Text('Home Page Content'),
      ),
    );
  }
}
