import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthRepositories {
  final String baseUrl = 'http://10.0.2.2:3000';

  Future<Map<String, dynamic>> signUp(
    String username,
    String password,
    String email,
    String phone,
  ) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'password': password,
        'email': email,
        'phone': phone,
      }),
    );
    return _handleResponse(response);
  }

  Future<Map<String, dynamic>> signIn(String username, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': username, 'password': password}),
    );
    return _handleResponse(response);
  }

  Map<String, dynamic> _handleResponse(http.Response response) {
    final body = jsonDecode(response.body);
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return {'success': true, 'data': body};
    } else {
      return {
        'success': false,
        'message': body['message'] ?? 'Terjadi kesalahan',
      };
    }
  }
}
