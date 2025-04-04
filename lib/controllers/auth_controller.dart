import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class AuthController extends ChangeNotifier {
  String? _token;
  bool _isLoading = false;

  String? get token => _token;
  bool get isLoading => _isLoading;

  Future<bool> login(String username, String password) async {
    _isLoading = true;
    notifyListeners(); 

    final response = await AuthService.login(username, password);


    _isLoading = false;
    notifyListeners();

    if (response != null && response.isNotEmpty) {
      _token = response;
      return true;
    } else {
      return false;
    }
  }
}
