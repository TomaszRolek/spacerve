import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

typedef MethodResponse<T> = void Function(T value);

enum Environment {
  dev(baseUrl: ''),
  aTest(baseUrl: ''),
  uat(baseUrl: ''),
  prod(baseUrl: '');

  const Environment({required this.baseUrl});

  final String baseUrl;

  String toShortString() {
    return toString().split('.').last;
  }
}

class FlavorConfig {
  FlavorConfig({required this.flavor});

  static const String channelName = 'flavor';
  static const String methodName = 'getFlavor';

  Environment flavor = Environment.dev;

  static late FlavorConfig _instance;

  static FlavorConfig getInstance() => _instance;

  static Future<void> configure(MethodResponse<bool> function) async {
    try {
      final flavor = await const MethodChannel(channelName).invokeMethod<String>(methodName);
      if (kDebugMode) {
        print('STARTED WITH FLAVOR $flavor');
      }
      await _setupEnvironment(flavor);
      function(true);
    } catch (error) {
      if (kDebugMode) {
        print('FAILED TO LOAD FLAVOR, error: $error');
      }
      function(false);
    }
  }

  static Future<void> _setupEnvironment(String? flavorName) async {
    final flavor = Environment.values.firstWhere((element) => element.toShortString() == flavorName);
    _instance = FlavorConfig(flavor: flavor);
  }
}
