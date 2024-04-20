import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

typedef BootstrapBuilder = Future<Widget> Function();

Future<void> bootstrap(BootstrapBuilder builder) async {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    await Supabase.initialize(
        url: 'https://sspvvzoyofflcddbxapl.supabase.co',
        anonKey:
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InNzcHZ2em95b2ZmbGNkZGJ4YXBsIiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTgzOTQ2NzAsImV4cCI6MjAxMzk3MDY3MH0.5__XwSjQme6UIZqpmFKoAy7dmbfxo134rsCYcb1tQjk');
    OneSignal.Debug.setLogLevel(OSLogLevel.verbose);

    OneSignal.initialize("5afb3b40-c484-4dfb-9b2e-24e72ed826c9");

    OneSignal.Notifications.requestPermission(true);

    await configureSystemUi();
    FlutterError.onError = (details) {
      if (kDebugMode) {
        print('Bootstrap file error');
        print([details.exceptionAsString(), details.stack]);
      }
    };

    runApp(await builder());

  }, (error, stackTrace) {
    if (kDebugMode) {
      print('Bootstrap file error - run zoned guarded');
      print([error.toString(), stackTrace]);
    }
  });
}

Future<void> configureSystemUi() async {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemStatusBarContrastEnforced: false,
      systemNavigationBarContrastEnforced: false,
      systemNavigationBarDividerColor: Colors.transparent,
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
      systemNavigationBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.transparent,
    ),
  );
  await SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.edgeToEdge,
    overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top],
  );
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
}
