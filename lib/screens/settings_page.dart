import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/theme_model.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Theme Settings',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Consumer<ThemeModel>(
              builder: (context, themeModel, child) {
                return SwitchListTile(
                  title: const Text('Dark Mode'),
                  value: themeModel.isDarkMode,
                  onChanged: (value) {
                    themeModel.setDarkMode(value);
                  },
                  secondary: const Icon(Icons.dark_mode),
                );
              },
            ),
            const Divider(),
            const Text(
              'Other Settings',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            ListTile(
              title: const Text('Notifications'),
              leading: const Icon(Icons.notifications),
              onTap: () {
                // Implement notification settings navigation or logic
              },
            ),
            ListTile(
              title: const Text('Privacy Settings'),
              leading: const Icon(Icons.privacy_tip),
              onTap: () {
                // Implement privacy settings navigation or logic
              },
            ),
          ],
        ),
      ),
    );
  }
}
