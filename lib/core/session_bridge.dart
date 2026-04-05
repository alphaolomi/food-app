import 'package:flutter/foundation.dart';

/// Links [ApiClient] 401 handling to [AuthProvider] without circular DI.
class SessionBridge {
  SessionBridge._();

  static VoidCallback? _onUnauthorized;

  static void register(VoidCallback callback) {
    _onUnauthorized = callback;
  }

  static Future<void> trigger() async {
    _onUnauthorized?.call();
  }

  @visibleForTesting
  static void reset() {
    _onUnauthorized = null;
  }
}
