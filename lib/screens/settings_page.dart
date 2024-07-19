import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/theme_model.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Theme Settings',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Consumer<ThemeModel>(
              builder: (context, themeModel, child) {
                return SwitchListTile(
                  title: Text('Dark Mode'),
                  value: themeModel.isDarkMode,
                  onChanged: (value) {
                    themeModel.setDarkMode(value);
                  },
                  secondary: Icon(Icons.dark_mode),
                );
              },
            ),
            Divider(),
            Text(
              'Other Settings',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            ListTile(
              title: Text('Notifications'),
              leading: Icon(Icons.notifications),
              onTap: () {
                // Implement notification settings navigation or logic
              },
            ),
            // ListTile(
            //   title: Text('Account Settings'),
            //   leading: Icon(Icons.account_circle),
            //   onTap: () {
            //     // Implement account settings navigation or logic
            //   },
            // ),
            ListTile(
              title: Text('Privacy Settings'),
              leading: Icon(Icons.privacy_tip),
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
