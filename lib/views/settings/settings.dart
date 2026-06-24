import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../config/color.dart';
import '../../config/extensions/build_context_ext.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/settings_controller.dart';
import '../widgets/app_button.dart';
import '../widgets/profile_header.dart';
import '../widgets/settings_tile.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          ProfileHeader(
            name: l10n.profileName,
            role: l10n.profileRole,
            avatarUrl: 'https://i.pravatar.cc/150?img=11',
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
              child: Consumer<SettingsController>(
                builder: (context, settings, _) {
                  return Column(
                    children: [
                      _SettingsCard(
                        children: [
                          SettingsTile(
                            icon: Icons.edit_outlined,
                            label: l10n.editProfile,
                            trailing: const Icon(
                              Icons.chevron_right,
                              color: AppColors.textGrey,
                            ),
                            onTap: () {},
                          ),
                          const _Divider(),
                          SettingsTile(
                            icon: Icons.notifications_outlined,
                            label: l10n.notifications,
                            trailing: Switch(
                              value: settings.notificationsEnabled,
                              onChanged: (_) =>
                                  context.read<SettingsController>().toggleNotifications(),
                              activeColor: AppColors.primary,
                            ),
                          ),
                          const _Divider(),
                          SettingsTile(
                            icon: Icons.dark_mode_outlined,
                            label: l10n.darkMode,
                            trailing: Switch(
                              value: settings.darkModeEnabled,
                              onChanged: (_) =>
                                  context.read<SettingsController>().toggleDarkMode(),
                              activeColor: AppColors.primary,
                            ),
                          ),
                          const _Divider(),
                          SettingsTile(
                            icon: Icons.info_outline,
                            label: l10n.appVersionLabel,
                            trailing: Text(
                              l10n.appVersion,
                              style: const TextStyle(
                                color: AppColors.textGrey,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      AppButton(
                        onPressed: () => _logout(context),
                        label: l10n.logOut,
                        color: AppColors.logoutText,
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _logout(BuildContext context) async {
    await context.read<AuthController>().logout();
    if (context.mounted) {
      Navigator.pushNamedAndRemoveUntil(context, '/login', (_) => false);
    }
  }
}

class _SettingsCard extends StatelessWidget {
  final List<Widget> children;

  const _SettingsCard({required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(12),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(children: children),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) {
    return const Divider(
      height: 1,
      thickness: 1,
      color: AppColors.divider,
      indent: 54,
    );
  }
}
