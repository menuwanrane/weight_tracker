import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/app_settings.dart';
import '../../data/respositories/settings_repository.dart';

final settingsRepositoryProvider = Provider<SettingsRepository>(
  (ref) => SettingsRepository(),
);

final settingsProvider =
    StateNotifierProvider<SettingsNotifier, AsyncValue<AppSettings>>(
      (ref) => SettingsNotifier(ref.read(settingsRepositoryProvider)),
    );

class SettingsNotifier extends StateNotifier<AsyncValue<AppSettings>> {
  final SettingsRepository repository;

  SettingsNotifier(this.repository)
    : super(const AsyncData(AppSettings.defaults())) {
    loadSettings();
  }

  Future<void> loadSettings() async {
    try {
      final settings = await repository.getSettings();
      state = AsyncData(settings);
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
    }
  }

  Future<void> updateThemeMode(ThemeMode themeMode) async {
    final current = state.value ?? const AppSettings.defaults();
    state = AsyncData(current.copyWith(themeMode: themeMode));

    await repository.updateThemeMode(themeMode);
  }

  Future<void> updateWeightUnit(String unit) async {
    final current = state.value ?? const AppSettings.defaults();
    state = AsyncData(current.copyWith(weightUnit: unit));

    await repository.updateWeightUnit(unit);
  }

  Future<void> updateNotificationsEnabled(bool enabled) async {
    final current = state.value ?? const AppSettings.defaults();
    state = AsyncData(current.copyWith(notificationsEnabled: enabled));

    await repository.updateNotificationsEnabled(enabled);
  }
}
