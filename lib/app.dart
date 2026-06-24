import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:aem_mobile/l10n/app_localizations.dart';
import 'config/theme.dart';
import 'config/route_generator.dart';
import 'controllers/auth_controller.dart';
import 'controllers/dashboard_controller.dart';
import 'controllers/settings_controller.dart';
import 'services/storage_service.dart';
import 'views/auth/login.dart';
import 'views/main_pages/bottom_navigation.dart';

class DevCorpApp extends StatelessWidget {
  const DevCorpApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthController()),
        ChangeNotifierProvider(create: (_) => DashboardController()),
        ChangeNotifierProvider(create: (_) => SettingsController()),
      ],
      child: const _AppMaterial(),
    );
  }
}

class _AppMaterial extends StatefulWidget {
  const _AppMaterial();

  @override
  State<_AppMaterial> createState() => _AppMaterialState();
}

class _AppMaterialState extends State<_AppMaterial> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AuthController>().loadStoredToken();
      context.read<SettingsController>().load();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DevCorp',
      debugShowCheckedModeBanner: false,
      theme: theme(context),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      onGenerateRoute: RouteGenerator.generateRoute,
      home: const _SplashRouter(),
    );
  }
}

class _SplashRouter extends StatefulWidget {
  const _SplashRouter();

  @override
  State<_SplashRouter> createState() => _SplashRouterState();
}

class _SplashRouterState extends State<_SplashRouter> {
  @override
  void initState() {
    super.initState();
    _route();
  }

  Future<void> _route() async {
    final token = await SecureStorage.getString('auth_token');
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => token != null && token.isNotEmpty
            ? const BottomNavigation()
            : const Login(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFF3D3BE8),
      body: Center(child: CircularProgressIndicator(color: Colors.white)),
    );
  }
}
