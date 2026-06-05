import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import '../database/database_helper.dart';
import '../models/app_settings.dart';

class SettingsRepository {
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  Future<AppSettings> getSettings() async {
    final values = await _getSettingsMap();

    return AppSettings(
      themeMode: _themeModeFromString(values['theme_mode']),
      weightUnit: values['weight_unit'] ?? 'KG',
      notificationsEnabled: values['notifications_enabled'] != 'false',
    );
  }

  Future<void> updateThemeMode(ThemeMode themeMode) async {
    await _saveSetting('theme_mode', themeMode.name);
  }

  Future<void> updateWeightUnit(String unit) async {
    await _saveSetting('weight_unit', unit);
  }

  Future<void> updateNotificationsEnabled(bool enabled) async {
    await _saveSetting('notifications_enabled', enabled.toString());
  }

  Future<Map<String, String>> _getSettingsMap() async {
    final db = await _dbHelper.database;
    final rows = await db.query('app_settings');

    return {
      for (final row in rows) row['key'] as String: row['value'] as String,
    };
  }

  Future<void> _saveSetting(String key, String value) async {
    final db = await _dbHelper.database;

    await db.insert('app_settings', {
      'key': key,
      'value': value,
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  ThemeMode _themeModeFromString(String? value) {
    return switch (value) {
      'light' => ThemeMode.light,
      'dark' => ThemeMode.dark,
      _ => ThemeMode.system,
    };
  }
}
