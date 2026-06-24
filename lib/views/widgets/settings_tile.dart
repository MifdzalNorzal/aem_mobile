import 'package:flutter/material.dart';
import '../../config/color.dart';

class SettingsTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final Widget trailing;
  final VoidCallback? onTap;

  const SettingsTile({
    super.key,
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
                style: const TextStyle(fontSize: 15, color: AppColors.textDark),
              ),
            ),
            trailing,
          ],
        ),
      ),
    );
  }
}
