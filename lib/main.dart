import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';
import 'presentation/widgets/bottom_nav_bar.dart';

void main() {
  runApp(const WeightTrackerApp());
}

class WeightTrackerApp extends StatelessWidget {
  const WeightTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weight Tracker',
      debugShowCheckedModeBanner: false,

      theme: AppTheme.lightTheme,

      darkTheme: AppTheme.darkTheme,

      themeMode: ThemeMode.system,

      home: const BottomNav(),
    );
  }
}