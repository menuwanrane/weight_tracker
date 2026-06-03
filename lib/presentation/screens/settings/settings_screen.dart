import 'package:flutter/material.dart';

import '../../widgets/settings_tile.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() =>
      _SettingsScreenState();
}

class _SettingsScreenState
    extends State<SettingsScreen> {
  bool notificationsEnabled = true;

  String selectedUnit = 'KG';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              const Text(
                'Settings',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 24),

              Text(
                'Appearance',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium,
              ),

              const SizedBox(height: 12),

              SettingsTile(
                icon: Icons.dark_mode_outlined,
                title: 'Theme',
                subtitle: 'Follow System',
                trailing: const Icon(
                  Icons.chevron_right,
                ),
                onTap: () {},
              ),

              const SizedBox(height: 20),

              Text(
                'Preferences',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium,
              ),

              const SizedBox(height: 12),

              SettingsTile(
                icon: Icons.straighten,
                title: 'Weight Unit',
                subtitle: selectedUnit,
                trailing: DropdownButton<String>(
                  value: selectedUnit,
                  underline: const SizedBox(),
                  items: const [
                    DropdownMenuItem(
                      value: 'KG',
                      child: Text('KG'),
                    ),
                    DropdownMenuItem(
                      value: 'LB',
                      child: Text('LB'),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      selectedUnit = value!;
                    });
                  },
                ),
              ),

              SettingsTile(
                icon: Icons.notifications_outlined,
                title: 'Notifications',
                trailing: Switch(
                  value: notificationsEnabled,
                  onChanged: (value) {
                    setState(() {
                      notificationsEnabled = value;
                    });
                  },
                ),
              ),

              const SizedBox(height: 20),

              Text(
                'About',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium,
              ),

              const SizedBox(height: 12),

              const SettingsTile(
                icon: Icons.info_outline,
                title: 'Version',
                subtitle: '1.0.0',
              ),

              const SizedBox(height: 20),

              Text(
                'Data',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium,
              ),

              const SizedBox(height: 12),

              SettingsTile(
                icon: Icons.delete_outline,
                iconColor: Colors.red,
                title: 'Delete All Data',
                subtitle:
                    'Remove all weight records',
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}