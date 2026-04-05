/// API base URL including `/api` prefix, no trailing slash.
///
/// ```bash
/// flutter run --dart-define=API_BASE_URL=http://10.0.2.2:8000/api   # Android emulator → host Laravel
/// flutter run --dart-define=API_BASE_URL=http://127.0.0.1:8000/api # iOS simulator
/// ```
class ApiConfig {
  ApiConfig._();

  static const String baseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://10.0.2.2:8000/api',
  );

  static const String paymentProviderStub = 'tz_mobile_money_stub';
}
