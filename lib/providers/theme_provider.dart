import 'package:flutter/material.dart';
import '../services/local_storage_service.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  ThemeProvider() {
    _isDarkMode = LocalStorageService.getUserProfile().isDarkMode;
  }

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    final profile = LocalStorageService.getUserProfile();
    LocalStorageService.saveUserProfile(profile.copyWith(isDarkMode: _isDarkMode));
    notifyListeners();
  }
}
