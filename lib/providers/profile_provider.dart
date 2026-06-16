import 'package:flutter/material.dart';
import '../models/user_profile.dart';
import '../services/local_storage_service.dart';

class ProfileProvider extends ChangeNotifier {
  late UserProfile _profile;

  UserProfile get profile => _profile;

  ProfileProvider() {
    _profile = LocalStorageService.getUserProfile();
  }

  Future<void> updateProfile(UserProfile newProfile) async {
    _profile = newProfile;
    await LocalStorageService.saveUserProfile(_profile);
    notifyListeners();
  }
}
