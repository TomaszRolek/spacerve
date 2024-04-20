import '../../../../services/router/app_router.dart';
import '../../services/router/app_routes.dart';

extension RegisterNavigator on AppRouter {
  void showDashboard() => router.goNamed(AppRoutes.dashboard);
}