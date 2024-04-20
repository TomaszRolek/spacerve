import '../../../../services/router/app_router.dart';
import '../../services/router/app_routes.dart';

extension WelcomeNavigator on AppRouter {
  void showLoginScreen() => router.pushNamed(AppRoutes.login);

  void showRegisterScreen() => router.pushNamed(AppRoutes.register);

  void showDashboard() => router.goNamed(AppRoutes.dashboard);

  void showWelcomeScreen() => router.goNamed(AppRoutes.welcome);
}