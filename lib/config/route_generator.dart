import 'package:flutter/material.dart';
import '../views/auth/login.dart';
import '../views/main_pages/bottom_navigation.dart';

class RouteGenerator {
  static const String login = '/login';
  static const String home = '/home';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => const Login());
      case home:
        return MaterialPageRoute(builder: (_) => const BottomNavigation());
      default:
        return MaterialPageRoute(builder: (_) => const Login());
    }
  }
}
