import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:spacerve/services/router/app_router.dart';

import '../generated/l10n.dart';
import '../services/app_service.dart';
import 'data/app_repository.dart';

class App extends StatelessWidget {
  const App({
    super.key,
    required AppService service,
    required AppRouter router, required AppRepository appRepository
  }) : _appService = service, _router = router, _appRepository =appRepository;

  final AppService _appService;
  final AppRouter _router;
  final AppRepository _appRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: _appService),
        RepositoryProvider.value(value: _router),
        RepositoryProvider.value(value: _appRepository)
      ],
      child: MaterialApp.router(
        // routerConfig: _router.router,
          routeInformationProvider: _router.router.routeInformationProvider,
          routeInformationParser: _router.router.routeInformationParser,
          routerDelegate: _router.router.routerDelegate,
          debugShowCheckedModeBanner: false,
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales
      ),
    );
  }
}
