import 'package:flutter/material.dart';
import '../../config/color.dart';

class ProfileHeader extends StatelessWidget {
  final String name;
  final String role;
  final String avatarUrl;

  const ProfileHeader({
    super.key,
    required this.name,
    required this.role,
    required this.avatarUrl,
  });

  @override
  Widget build(BuildContext context) {
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
            backgroundImage: NetworkImage(avatarUrl),
            backgroundColor: Colors.white.withAlpha(40),
          ),
          const SizedBox(height: 14),
          Text(
            name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            role,
            style: const TextStyle(color: Colors.white70, fontSize: 14),
          ),
        ],
      ),
    );
  }
}
