import 'package:estante/models/api_response_model.dart';
import 'package:flutter/material.dart';

import '../models/user_model.dart';
import 'api_service.dart';

class AuthService extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  UserModel? _user;
  String? _token;

  UserModel? get user => _user;
  String? get token => _token;
  bool get isAuthenticated => _user != null && _token != null;

  Future<void> login(String email, String password) async {
    if (email.isEmpty || password.isEmpty) return;

    final Map<String, String> data = {
      'email': email,
      'password': password
    };

    try {
      final ApiResponseModel response = await _apiService.post("/login", body: data);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = response.body as Map<String, dynamic>;

        _token = responseData['token'];
        _user = UserModel.fromJson(responseData['user']);

        notifyListeners();
      }
    } catch (e) {
      throw Exception('Falha no login: $e');
    }
  }

  Future<void> logout() async {
    _user = null;
    notifyListeners();
  }
}