import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/extensions/build_context_ext.dart';
import '../providers/settings_provider.dart';
import '../../auth/providers/auth_provider.dart';
import '../../auth/screens/login_screen.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    final l10n = context.l10n;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          _buildProfileHeader(context),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
              child: Column(
                children: [
                  _SettingsCard(
                    children: [
                      _SettingsTile(
                        icon: Icons.edit_outlined,
                        label: l10n.editProfile,
                        trailing: const Icon(
                          Icons.chevron_right,
                          color: AppColors.textGrey,
                        ),
                        onTap: () {},
                      ),
                      const _Divider(),
                      _SettingsTile(
                        icon: Icons.notifications_outlined,
                        label: l10n.notifications,
                        trailing: Switch(
                          value: settings.notificationsEnabled,
                          onChanged: (_) =>
                              ref.read(settingsProvider.notifier).toggleNotifications(),
                          activeColor: AppColors.primary,
                        ),
                      ),
                      const _Divider(),
                      _SettingsTile(
                        icon: Icons.dark_mode_outlined,
                        label: l10n.darkMode,
                        trailing: Switch(
                          value: settings.darkModeEnabled,
                          onChanged: (_) =>
                              ref.read(settingsProvider.notifier).toggleDarkMode(),
                          activeColor: AppColors.primary,
                        ),
                      ),
                      const _Divider(),
                      _SettingsTile(
                        icon: Icons.info_outline,
                        label: l10n.appVersionLabel,
                        trailing: Text(
                          l10n.appVersion,
                          style: const TextStyle(color: AppColors.textGrey, fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  _LogoutButton(
                    onTap: () => _logout(context, ref),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context) {
    return Container(
      color: AppColors.primary,
      width: double.infinity,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 20,
        bottom: 28,
        left: 24,
        right: 24,
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 42,
            backgroundImage: const NetworkImage('https://i.pravatar.cc/150?img=11'),
            backgroundColor: Colors.white.withAlpha(40),
          ),
          const SizedBox(height: 14),
          Text(
            context.l10n.profileName,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            context.l10n.profileRole,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _logout(BuildContext context, WidgetRef ref) async {
    await ref.read(authProvider.notifier).logout();
    if (context.mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
        (_) => false,
      );
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

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final Widget trailing;
  final VoidCallback? onTap;

  const _SettingsTile({
    required this.icon,
    required this.label,
    required this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        child: Row(
          children: [
            Icon(icon, color: AppColors.textDark, size: 22),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 15,
                  color: AppColors.textDark,
                ),
              ),
            ),
            trailing,
          ],
        ),
      ),
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

class _LogoutButton extends StatelessWidget {
  final VoidCallback onTap;

  const _LogoutButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Material(
        color: AppColors.logoutBackground,
        borderRadius: BorderRadius.circular(14),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(14),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Text(
              context.l10n.logOut,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColors.logoutText,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
