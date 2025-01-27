import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class LoginViewModel extends ChangeNotifier {
  final AuthService _authService;
  bool _isLoading = false;

  LoginViewModel(this._authService);

  bool get isLoading => _isLoading;

  Future<bool> signInWithEmail(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      final user = await _authService.signInWithEmail(email, password);
      return user != null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> signInWithGoogle() async {
    _isLoading = true;
    notifyListeners();

    try {
      final user = await _authService.signInWithGoogle();
      return user != null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}