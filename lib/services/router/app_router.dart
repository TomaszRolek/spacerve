import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:spacerve/features/dashboard/dashboard_page.dart';
import 'package:spacerve/features/reserve/reserve_page.dart';

import '../../features/login/login_page.dart';
import '../../features/register/register_page.dart';
import '../../features/welcome/welcome_page.dart';
import '../app_service.dart';

import 'app_routes.dart';

class AppRouter {
  AppRouter(this._appRepository);

  final AppService _appRepository;

  late final GoRouter router = GoRouter(
    routes: <GoRoute>[
      GoRoute(
        name: AppRoutes.welcome,
        path: '/',
        builder: (_, __) => const WelcomePage(),
        redirect: (_, __) async => await _appRepository.isLogged ? '/dashboard' : '/',
      ),
      GoRoute(
          name: AppRoutes.login,
          path: '/login',
          builder: (BuildContext context, GoRouterState state) {
            return const LoginPage();
          }),
      GoRoute(
          name: AppRoutes.register,
          path: '/register',
          builder: (BuildContext context, GoRouterState state) {
            return const RegisterPage();
          }),
      GoRoute(
          name: AppRoutes.dashboard,
          path: '/dashboard',
          builder: (BuildContext context, GoRouterState state) {
            return const DashboardPage();
          }),
      GoRoute(
          name: AppRoutes.reserve,
          path: '/reserve',
          builder: (BuildContext context, GoRouterState state) {
            final extrasMap = state.extra! as Map<String, Object?>;
            return ReservePage(id: extrasMap['id'] as int);
          }),
    ],
  );

  void back({dynamic arguments}) => router.pop(arguments);
}
