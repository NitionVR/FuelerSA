import 'package:flutter/material.dart';

import '../services/auth_service.dart';

class SignupViewModel extends ChangeNotifier {
  final AuthService _authService;
  bool _isLoading = false;

  SignupViewModel(this._authService);

  bool get isLoading => _isLoading;

  Future<bool> registerWithEmail(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      final user = await _authService.registerWithEmail(email, password);
      return user != null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}