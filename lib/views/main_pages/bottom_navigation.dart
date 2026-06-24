import 'package:flutter/material.dart';
import '../../config/color.dart';
import '../../config/extensions/build_context_ext.dart';
import '../home/home.dart';
import '../info/info.dart';
import '../settings/settings.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _currentIndex = 0;

  static const _screens = [
    Home(),
    Info(),
    Settings(),
  ];

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) => setState(() => _currentIndex = index),
        backgroundColor: Colors.white,
        indicatorColor: AppColors.primary.withAlpha(30),
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.home_outlined),
            selectedIcon: const Icon(Icons.home, color: AppColors.primary),
            label: l10n.navHome,
          ),
          NavigationDestination(
            icon: const Icon(Icons.info_outline),
            selectedIcon: const Icon(Icons.info, color: AppColors.primary),
            label: l10n.navInfo,
          ),
          NavigationDestination(
            icon: const Icon(Icons.settings_outlined),
            selectedIcon: const Icon(Icons.settings, color: AppColors.primary),
            label: l10n.navSettings,
          ),
        ],
      ),
    );
  }
}
