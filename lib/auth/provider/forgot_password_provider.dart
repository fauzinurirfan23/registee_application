import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ForgotPasswordProvider with ChangeNotifier {
  bool _isLoading = false;
  String? _message;

  bool get isLoading => _isLoading;
  String? get message => _message;

  Future<void> forgotPassword(String username, String newPassword) async {
    _isLoading = true;
    _message = null;
    notifyListeners();

    //final String baseUrl = 'http://10.0.2.2:3000';
    final String baseUrl = 'http://192.168.0.105:3000';

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/forgot-password'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'username': username, 'newPassword': newPassword}),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        _message = data['message'];
      } else {
        _message = data['message'] ?? 'Terjadi kesalahan';
      }
    } catch (e) {
      _message = 'Gagal terhubung ke server';
    }

    _isLoading = false;
    notifyListeners();
  }
}
