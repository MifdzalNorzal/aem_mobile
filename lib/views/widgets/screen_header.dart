import 'package:flutter/material.dart';
import '../../config/color.dart';

class ScreenHeader extends StatelessWidget {
  final String title;

  const ScreenHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).padding.top;
    return Container(
      height: statusBarHeight + 140,
      padding: EdgeInsets.only(top: statusBarHeight + 30, left: 24, right: 24),
      alignment: Alignment.topCenter,
      decoration: const BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(30),
        ),
      ),
      width: double.infinity,
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 26,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
