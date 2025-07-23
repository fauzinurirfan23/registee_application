// providers/user_detail_provider.dart
import 'package:flutter/material.dart';
import 'package:register_app/home/models/detail_users.dart';
import 'package:register_app/home/repositories/users_repositories.dart';

class UserDetailProvider with ChangeNotifier {
  final UserRepositories _repo = UserRepositories();

  UsersDetail? _userDetail;
  bool _isLoading = false;
  String? _error;

  UsersDetail? get user => _userDetail;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchUserById(int id) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final fetchedUser = await _repo.fetchUserDetail(id);
      _userDetail = fetchedUser;
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  void clearUser() {
    _userDetail = null;
    _error = null;
    notifyListeners();
  }
}
