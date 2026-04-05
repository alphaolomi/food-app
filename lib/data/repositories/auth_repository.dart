import '../../core/api/api_client.dart';
import '../../core/api/token_storage.dart';
import '../models/user_model.dart';

class AuthRepository {
  AuthRepository({required ApiClient client, required TokenStorage storage})
      : _client = client,
        _storage = storage;

  final ApiClient _client;
  final TokenStorage _storage;

  Future<AppUser> register({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
  }) async {
    final res = await _client.post<Map<String, dynamic>>(
      '/v1/auth/register',
      data: {
        'name': name,
        'email': email,
        'password': password,
        'password_confirmation': passwordConfirmation,
      },
    );
    final data = res.data!;
    final token = data['token'] as String;
    await _storage.writeToken(token);
    return AppUser.fromJson(data['user'] as Map<String, dynamic>);
  }

  Future<AppUser> login({required String email, required String password}) async {
    final res = await _client.post<Map<String, dynamic>>(
      '/v1/auth/login',
      data: {'email': email, 'password': password},
    );
    final data = res.data!;
    final token = data['token'] as String;
    await _storage.writeToken(token);
    return AppUser.fromJson(data['user'] as Map<String, dynamic>);
  }

  Future<void> logout() async {
    try {
      await _client.post<dynamic>('/v1/auth/logout');
    } catch (_) {
      // Token may already be invalid; still clear locally.
    }
    await _storage.clear();
  }

  Future<AppUser?> profile() async {
    final token = await _storage.readToken();
    if (token == null || token.isEmpty) return null;
    final res = await _client.get<Map<String, dynamic>>('/v1/user');
    return AppUser.fromJson(res.data!);
  }
}
