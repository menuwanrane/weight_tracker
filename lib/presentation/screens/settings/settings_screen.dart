import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/settings_provider.dart';
import '../../providers/weight_provider.dart';
import '../../widgets/settings_tile.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(settingsProvider);

    return Scaffold(
      body: settings.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Text(error.toString()),
          ),
        ),
        data: (data) => SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Settings',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 24),

                Text(
                  'Appearance',
                  style: Theme.of(context).textTheme.titleMedium,
                ),

                const SizedBox(height: 12),

                SettingsTile(
                  icon: Icons.dark_mode_outlined,
                  title: 'Theme',
                  subtitle: _themeLabel(data.themeMode),
                  child: SegmentedButton<ThemeMode>(
                    segments: const [
                      ButtonSegment(
                        value: ThemeMode.system,
                        icon: Icon(Icons.brightness_auto),
                      ),
                      ButtonSegment(
                        value: ThemeMode.light,
                        icon: Icon(Icons.light_mode),
                      ),
                      ButtonSegment(
                        value: ThemeMode.dark,
                        icon: Icon(Icons.dark_mode),
                      ),
                    ],
                    selected: {data.themeMode},
                    onSelectionChanged: (selected) {
                      ref
                          .read(settingsProvider.notifier)
                          .updateThemeMode(selected.first);
                    },
                  ),
                ),

                const SizedBox(height: 20),

                Text(
                  'Preferences',
                  style: Theme.of(context).textTheme.titleMedium,
                ),

                const SizedBox(height: 12),

                SettingsTile(
                  icon: Icons.straighten,
                  title: 'Weight Unit',
                  subtitle: data.weightUnit,
                  child: SegmentedButton<String>(
                    segments: const [
                      ButtonSegment(value: 'KG', label: Text('KG')),
                      ButtonSegment(value: 'LB', label: Text('LB')),
                    ],
                    selected: {data.weightUnit},
                    onSelectionChanged: (selected) {
                      ref
                          .read(settingsProvider.notifier)
                          .updateWeightUnit(selected.first);
                    },
                  ),
                ),

                SettingsTile(
                  icon: Icons.notifications_outlined,
                  title: 'Notifications',
                  subtitle: data.notificationsEnabled ? 'Enabled' : 'Disabled',
                  trailing: Switch(
                    value: data.notificationsEnabled,
                    onChanged: (value) {
                      ref
                          .read(settingsProvider.notifier)
                          .updateNotificationsEnabled(value);
                    },
                  ),
                ),

                const SizedBox(height: 20),

                Text('About', style: Theme.of(context).textTheme.titleMedium),

                const SizedBox(height: 12),

                const SettingsTile(
                  icon: Icons.info_outline,
                  title: 'Version',
                  subtitle: '1.0.0',
                ),

                const SizedBox(height: 20),

                Text('Data', style: Theme.of(context).textTheme.titleMedium),

                const SizedBox(height: 12),

                SettingsTile(
                  icon: Icons.delete_outline,
                  iconColor: Colors.red,
                  title: 'Delete All Data',
                  subtitle: 'Remove all weight records',
                  onTap: _deleteAllData,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _themeLabel(ThemeMode themeMode) {
    return switch (themeMode) {
      ThemeMode.light => 'Light',
      ThemeMode.dark => 'Dark',
      ThemeMode.system => 'Follow System',
    };
  }

  Future<void> _deleteAllData() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete all data?'),
        content: const Text('This removes every saved weight record.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed != true) {
      return;
    }

    await ref.read(weightProvider.notifier).deleteAllWeights();
  }
}
