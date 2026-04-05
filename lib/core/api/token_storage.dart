import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStorage {
  TokenStorage({FlutterSecureStorage? storage})
    : _storage =
          storage ??
          const FlutterSecureStorage();

  static const _key = 'sanctum_token';

  final FlutterSecureStorage _storage;

  Future<String?> readToken() => _storage.read(key: _key);

  Future<void> writeToken(String token) =>
      _storage.write(key: _key, value: token);

  Future<void> clear() => _storage.delete(key: _key);
}
