import 'package:flutter/material.dart';
import '../../config/color.dart';

class ScreenHeader extends StatelessWidget {
  final Widget child;

  const ScreenHeader({super.key, required this.child});

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
      child: child,
    );
  }
}


class ScreenHeader2 extends StatelessWidget {
  final Widget child;

  const ScreenHeader2({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).padding.top;
    return Container(
      height: statusBarHeight + 120,
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


class ScreenHeader3 extends StatelessWidget {
  final Widget child;

  const ScreenHeader3({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).padding.top;
    return Container(
      height: statusBarHeight + 205,
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