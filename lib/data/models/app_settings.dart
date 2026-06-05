import 'package:flutter/material.dart';

class AppSettings {
  final ThemeMode themeMode;
  final String weightUnit;
  final bool notificationsEnabled;

  const AppSettings({
    required this.themeMode,
    required this.weightUnit,
    required this.notificationsEnabled,
  });

  const AppSettings.defaults()
    : themeMode = ThemeMode.system,
      weightUnit = 'KG',
      notificationsEnabled = true;

  AppSettings copyWith({
    ThemeMode? themeMode,
    String? weightUnit,
    bool? notificationsEnabled,
  }) {
    return AppSettings(
      themeMode: themeMode ?? this.themeMode,
      weightUnit: weightUnit ?? this.weightUnit,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
    );
  }
}
