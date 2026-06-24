import 'package:flutter/material.dart';
import '../views/auth/login.dart';
import '../views/main_pages/bottom_navigation.dart';

class RouteGenerator {
  static const String login = '/login';
  static const String home = '/home';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // Auth
      case '/login':
        return MaterialPageRoute(
          builder: ((context) => const Login()),
          settings: settings,
        );

      // Main
      case '/home':
        return MaterialPageRoute(
          builder: ((context) => const BottomNavigation()),
          settings: settings,
        );

      default:
        return MaterialPageRoute(
          builder: ((context) => const Login()),
          settings: settings,
        );
    }
  }
}
