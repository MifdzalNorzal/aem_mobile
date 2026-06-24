import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsState {
  final bool notificationsEnabled;
  final bool darkModeEnabled;

  const SettingsState({
    this.notificationsEnabled = true,
    this.darkModeEnabled = false,
  });

  SettingsState copyWith({bool? notificationsEnabled, bool? darkModeEnabled}) {
    return SettingsState(
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      darkModeEnabled: darkModeEnabled ?? this.darkModeEnabled,
    );
  }
}

class SettingsNotifier extends StateNotifier<SettingsState> {
  SettingsNotifier() : super(const SettingsState());

  void toggleNotifications() {
    state = state.copyWith(notificationsEnabled: !state.notificationsEnabled);
  }

  void toggleDarkMode() {
    state = state.copyWith(darkModeEnabled: !state.darkModeEnabled);
  }
}

final settingsProvider = StateNotifierProvider<SettingsNotifier, SettingsState>((ref) {
  return SettingsNotifier();
});
