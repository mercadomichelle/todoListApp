import 'package:flutter/material.dart';
import 'package:appdev_proj/widgets/app_drawer.dart';

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
