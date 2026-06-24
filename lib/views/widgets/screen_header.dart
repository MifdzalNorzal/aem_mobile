import 'package:flutter/material.dart';
import '../../config/color.dart';

class ScreenHeader extends StatelessWidget {
  final String title;

  const ScreenHeader({super.key, required this.title});

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
