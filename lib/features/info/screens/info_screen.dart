import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/extensions/build_context_ext.dart';
import '../../../features/home/providers/dashboard_provider.dart';
import '../../../models/table_user_model.dart';

const _avatarUrls = [
  'https://i.pravatar.cc/150?img=11',
  'https://i.pravatar.cc/150?img=5',
  'https://i.pravatar.cc/150?img=47',
  'https://i.pravatar.cc/150?img=20',
  'https://i.pravatar.cc/150?img=32',
  'https://i.pravatar.cc/150?img=25',
  'https://i.pravatar.cc/150?img=15',
  'https://i.pravatar.cc/150?img=60',
];

class InfoScreen extends ConsumerStatefulWidget {
  const InfoScreen({super.key});

  @override
  ConsumerState<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends ConsumerState<InfoScreen> {
  final _searchController = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<TableUserModel> _filter(List<TableUserModel> users) {
    if (_query.isEmpty) return users;
    final q = _query.toLowerCase();
    return users.where((u) => u.name.toLowerCase().contains(q)).toList();
  }

  @override
  Widget build(BuildContext context) {
    final dashboardAsync = ref.watch(dashboardProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            _SearchBar(
              controller: _searchController,
              onChanged: (v) => setState(() => _query = v),
            ),
            Expanded(
              child: dashboardAsync.when(
                loading: () => const Center(
                  child: CircularProgressIndicator(color: AppColors.primary),
                ),
                error: (_, __) => Center(
                  child: Text(
                    context.l10n.failedLoadEmployees,
                    style: const TextStyle(color: AppColors.textGrey),
                  ),
                ),
                data: (dashboard) {
                  final users = _filter(dashboard.tableUsers);
                  if (users.isEmpty) {
                    return Center(
                      child: Text(
                        context.l10n.noResultsFound,
                        style: const TextStyle(color: AppColors.textGrey),
                      ),
                    );
                  }
                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      return _EmployeeTile(
                        user: users[index],
                        avatarUrl: _avatarUrls[index % _avatarUrls.length],
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SearchBar extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  const _SearchBar({required this.controller, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primary,
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        style: const TextStyle(color: Colors.black87),
        decoration: InputDecoration(
          hintText: context.l10n.search,
          hintStyle: const TextStyle(color: Colors.grey),
          prefixIcon: const Icon(Icons.search, color: Colors.grey),
          suffixIcon: const Icon(Icons.tune_outlined, color: Colors.grey),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}

class _EmployeeTile extends StatelessWidget {
  final TableUserModel user;
  final String avatarUrl;

  const _EmployeeTile({required this.user, required this.avatarUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
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
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
            color: AppColors.textDark,
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
