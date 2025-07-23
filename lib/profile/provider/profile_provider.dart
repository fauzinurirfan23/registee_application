import 'package:flutter/material.dart';
import 'package:register_app/profile/repositories/profile_repositories.dart';
import '../models/profile_model.dart';

class ProfileProvider with ChangeNotifier {
  final ProfileRepository _repository = ProfileRepository();

  ProfileModel? _profile;
  bool _isLoading = false;

  ProfileModel? get profile => _profile;
  bool get isLoading => _isLoading;

  Future<void> fetchProfileById(int userId) async {
    _isLoading = true;
    notifyListeners();

    _profile = await _repository.getProfileById(userId);

    _isLoading = false;
    notifyListeners();
  }
}
