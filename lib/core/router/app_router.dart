import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/command_history/command_history_page.dart';
import '../../features/home/home_page.dart';
import '../../features/permissions/permissions_page.dart';
import '../../features/settings/settings_page.dart';
import '../../features/splash/splash_page.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(path: '/', builder: (context, state) => const SplashPage()),
      GoRoute(path: '/home', builder: (context, state) => const HomePage()),
      GoRoute(
        path: '/permissions',
        builder: (context, state) => const PermissionsPage(),
      ),
      GoRoute(
        path: '/history',
        builder: (context, state) => const CommandHistoryPage(),
      ),
      GoRoute(path: '/settings', builder: (context, state) => const SettingsPage()),
    ],
  );
});
