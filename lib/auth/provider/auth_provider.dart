import 'package:flutter/material.dart';
import 'package:register_app/auth/auth_repositories.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  final AuthRepositories _authService = AuthRepositories();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<Map<String, dynamic>> login(String username, String password) async {
    _isLoading = true;
    notifyListeners();

    final result = await _authService.signIn(username, password);

    _isLoading = false;
    notifyListeners();

    if (result['success']) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt('userId', result['data']['user']['id']);
      await prefs.setString('username', result['data']['user']['username']);
    }

    return result;
  }

  Future<Map<String, dynamic>> signUp(
    String username,
    String password,
    String email,
    String phone,
  ) async {
    _isLoading = true;
    notifyListeners();

    final result = await _authService.signUp(username, password, email, phone);

    _isLoading = false;
    notifyListeners();

    return result;
  }
}
