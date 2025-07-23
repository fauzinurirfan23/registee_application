import 'dart:convert';

import 'package:register_app/home/models/detail_users.dart';
import 'package:register_app/home/models/users_model.dart';
import 'package:http/http.dart' as http;

class UserRepositories {
  final String baseUrl = 'http://10.0.2.2:3000';

  Future<GetUser> fetchUsers({int page = 1, int limit = 10}) async {
    final response = await http.get(
      Uri.parse('$baseUrl/users?page=$page&limit=$limit'),
    );

    if (response.statusCode == 200) {
      return GetUser.fromJson(json.decode(response.body));
    } else {
      throw Exception('Gagal mengambil data user');
    }
  }

  Future<UsersDetail> fetchUserDetail(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/users/$id'));

    if (response.statusCode == 200) {
      return UsersDetail.fromJson(json.decode(response.body));
    } else {
      throw Exception('Gagal mengambil data user dengan ID $id');
    }
  }
}
