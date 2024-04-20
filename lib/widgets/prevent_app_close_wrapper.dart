import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PreventAppCloseWrapper extends StatelessWidget {
  const PreventAppCloseWrapper({super.key, required this.child});

  final Widget child;

  MethodChannel get _androidAppRetain => const MethodChannel('android_app_retain');

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (Platform.isAndroid) {
          if (Navigator.of(context).canPop()) {
            return Future.value(true);
          } else {
            _androidAppRetain.invokeMethod('sendToBackground');
            return Future.value(false);
          }
        } else {
          return Future.value(true);
        }
      },
      child: child,
    );
  }
}