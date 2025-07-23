import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/profile_model.dart';

class ProfileRepository {
  //final String baseUrl = 'http://10.0.2.2:3000';
  final String baseUrl = 'http://192.168.0.105:3000';

  Future<ProfileModel?> getProfileById(int userId) async {
    final url = Uri.parse('$baseUrl/profile/$userId');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return ProfileModel.fromJson(jsonData);
      } else {
        return null;
      }
    } catch (e) {
      print('Error fetch profile: $e');
      return null;
    }
  }
}
