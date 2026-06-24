import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../config/color.dart';
import '../../config/extensions/build_context_ext.dart';
import '../../controllers/dashboard_controller.dart';
import '../../model/table_user_model.dart';
import '../widgets/employee_tile.dart';
import '../widgets/screen_headers.dart';

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

class Info extends StatefulWidget {
  const Info({super.key});

  @override
  State<Info> createState() => _InfoState();
}

class _InfoState extends State<Info> {
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
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          ScreenHeader2(
            child: _SearchBar(
              controller: _searchController,
              onChanged: (v) => setState(() => _query = v),
            ),
          ),
          Expanded(
            child: Consumer<DashboardController>(
              builder: (context, dashboard, _) {
                if (dashboard.isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(color: AppColors.primary),
                  );
                }
                if (dashboard.error != null) {
                  return Center(
                    child: Text(
                      context.l10n.failedLoadEmployees,
                      style: const TextStyle(color: AppColors.textGrey),
                    ),
                  );
                }
                final users = _filter(dashboard.data?.tableUsers ?? []);
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
                    return EmployeeTile(
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
    );
  }
}

class _SearchBar extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  const _SearchBar({required this.controller, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextField(
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
    );
  }
}
