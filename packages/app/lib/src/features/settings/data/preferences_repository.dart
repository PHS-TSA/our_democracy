import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../domain/settings_model.dart';

part 'preferences_repository.g.dart';

abstract interface class PreferencesRepository {
  /// Load the user's settings from a local database or the internet.
  Future<SettingsModel> load();

  /// Persist the user's settings to a local database or the internet.
  Future<void> setString(String key, String value);
}

class _SharedPreferencesRepository implements PreferencesRepository {
  _SharedPreferencesRepository(this.prefs);

  final SharedPreferencesWithCache prefs;

  @override
  Future<SettingsModel> load() => loadSettings(prefs);

  @override
  Future<void> setString(String key, String value) async =>
      await prefs.setString(key, value);
}

@Riverpod(keepAlive: true)
PreferencesRepository preferencesRepository(PreferencesRepositoryRef ref) {
  final prefs = ref.watch(sharedPreferencesProvider);

  return _SharedPreferencesRepository(prefs);
}

@internal
Future<SettingsModel> loadSettings(
  SharedPreferencesWithCache prefs,
) async {
  final data = prefs.getString('prefs');
  final Object? decoded = data == null ? null : json.decode(data);

  return decoded is Map<String, Object?>
      ? SettingsModel.fromJson(decoded)
      : defaultSettings;
}

@Riverpod(keepAlive: true)
SharedPreferencesWithCache sharedPreferences(SharedPreferencesRef ref) {
  throw UnimplementedError();
}

const defaultSettings = SettingsModel(themeMode: ThemeMode.system);
