import 'package:spacerve/services/app_service.dart';
import 'package:spacerve/services/router/app_router.dart';
import 'app.dart';
import 'bootstrap.dart';
import 'data/app_repository.dart';
import 'data/auth_client.dart';

void main() async {
  await bootstrap(() async {
    final appAuthClient = AuthClient();
    final appService = AppService(appAuthClient);
    final appRepository = AppRepository(appService);
    final router = AppRouter(appService);

    return App(service: appService, router: router, appRepository: appRepository);
  });
}
