import 'package:estante/entities/api_response.dart';
import 'package:flutter/material.dart';

import 'api_service.dart';

class UserModel {
  final String name;
  final String email;
  UserModel({required this.name, required this.email});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'] ?? '',
      email: json['email'] ?? '',
    );
  }
}

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
      final ApiResponse response = await _apiService.post("/login", body: data);

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