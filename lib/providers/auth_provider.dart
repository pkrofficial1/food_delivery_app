import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  bool _isAuthenticated = false;
  String? _userId;
  bool _hasCompletedOnboarding = false;

  bool get isAuthenticated => _isAuthenticated;
  String? get userId => _userId;
  bool get hasCompletedOnboarding => _hasCompletedOnboarding;

  AuthProvider() {
    _loadAuthState();
  }

  Future<void> _loadAuthState() async {
    final prefs = await SharedPreferences.getInstance();
    _isAuthenticated = prefs.getBool('isAuthenticated') ?? false;
    _userId = prefs.getString('userId');
    _hasCompletedOnboarding = prefs.getBool('hasCompletedOnboarding') ?? false;
    notifyListeners();
  }

  Future<void> login(String userId) async {
    _isAuthenticated = true;
    _userId = userId;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isAuthenticated', true);
    await prefs.setString('userId', userId);

    notifyListeners();
  }

  Future<void> logout() async {
    _isAuthenticated = false;
    _userId = null;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isAuthenticated', false);
    await prefs.remove('userId');

    notifyListeners();
  }

  Future<void> completeOnboarding() async {
    _hasCompletedOnboarding = true;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('hasCompletedOnboarding', true);

    notifyListeners();
  }
}
