import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  final bool isDark;
  final Function(bool) onThemeChanged;

  SettingsScreen({required this.isDark, required this.onThemeChanged});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: ListView(
        children: [
          ListTile(
            title: Text('Dark Mode'),
            trailing: Switch(
              value: isDark,
              onChanged: (value) {
                onThemeChanged(value);
              },
            ),
          ),
        ],
      ),
    );
  }
}
