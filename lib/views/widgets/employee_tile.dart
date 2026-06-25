import 'package:flutter/material.dart';
import '../../config/color.dart';
import '../../config/extensions/build_context_ext.dart';
import '../../model/table_user_model.dart';

class EmployeeTile extends StatelessWidget {
  final TableUserModel user;
  final String avatarUrl;

  const EmployeeTile({super.key, required this.user, required this.avatarUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(10),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: CircleAvatar(
          radius: 28,
          backgroundImage: NetworkImage(avatarUrl),
          backgroundColor: AppColors.primary.withAlpha(30),
        ),
        title: Text(
          user.name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 2),
            Text(
              user.department ?? context.l10n.defaultDepartment,
              style: const TextStyle(fontSize: 12, color: AppColors.textGrey),
            ),
            Text(
              user.role ?? context.l10n.defaultRole,
              style: const TextStyle(fontSize: 12, color: AppColors.textGrey),
            ),
          ],
        ),
        trailing: const Icon(Icons.chevron_right, color: AppColors.textGrey),
        onTap: () {},
      ),
    );
  }
}
