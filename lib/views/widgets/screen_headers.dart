import 'package:flutter/material.dart';
import '../../config/color.dart';

class ScreenHeader extends StatelessWidget {
  final Widget child;
  final double height;

  const ScreenHeader({super.key, required this.child, this.height = 140});

  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).padding.top;
    return Container(
      height: statusBarHeight + height,
      padding: EdgeInsets.only(top: statusBarHeight + 30, left: 24, right: 24),
      alignment: Alignment.topCenter,
      decoration: const BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(30),
        ),
      ),
      width: double.infinity,
      child: child,
    );
  }
}