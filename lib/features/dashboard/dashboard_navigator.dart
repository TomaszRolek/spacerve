import '../../../../services/router/app_router.dart';
import '../../services/router/app_routes.dart';

extension DashboardNavigator on AppRouter {
  void reserve(int id) => router.pushNamed(AppRoutes.reserve, extra: <String, Object?>{'id': id});
}
