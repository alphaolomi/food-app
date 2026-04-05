import 'package:flutter/foundation.dart';

import '../core/api/api_exception.dart';
import '../data/models/user_model.dart';
import '../data/repositories/auth_repository.dart';

class AuthProvider extends ChangeNotifier {
  AuthProvider({required AuthRepository repository}) : _repository = repository;

  final AuthRepository _repository;

  AppUser? _user;
  bool _bootstrapping = true;
  String? _lastError;

  AppUser? get user => _user;
  bool get bootstrapping => _bootstrapping;
  bool get isAuthenticated => _user != null;
  String? get lastError => _lastError;

  /// Clears session after 401 from API (token already removed by [ApiClient]).
  Future<void> sessionExpired() async {
    _user = null;
    _lastError = null;
    notifyListeners();
  }

  Future<void> bootstrap() async {
    _bootstrapping = true;
    _lastError = null;
    notifyListeners();
    try {
      _user = await _repository.profile();
    } catch (_) {
      _user = null;
    }
    _bootstrapping = false;
    notifyListeners();
  }

  Future<bool> login(String email, String password) async {
    _lastError = null;
    notifyListeners();
    try {
      _user = await _repository.login(email: email, password: password);
      notifyListeners();
      return true;
    } on ApiException catch (e) {
      _lastError = e.message;
      notifyListeners();
      return false;
    }
  }

  Future<bool> register({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
  }) async {
    _lastError = null;
    notifyListeners();
    try {
      _user = await _repository.register(
        name: name,
        email: email,
        password: password,
        passwordConfirmation: passwordConfirmation,
      );
      notifyListeners();
      return true;
    } on ApiException catch (e) {
      _lastError = _formatRegisterError(e);
      notifyListeners();
      return false;
    }
  }

  String _formatRegisterError(ApiException e) {
    final fe = e.fieldErrors;
    if (fe != null && fe.isNotEmpty) {
      final parts = <String>[];
      for (final entry in fe.entries) {
        parts.add('${entry.key}: ${entry.value.join(', ')}');
      }
      return parts.join('\n');
    }
    return e.message;
  }

  Future<void> logout() async {
    await _repository.logout();
    _user = null;
    _lastError = null;
    notifyListeners();
  }
}
