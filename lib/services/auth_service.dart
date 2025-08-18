import 'package:flutter/material.dart';

// Modelo simples para representar o usuário logado
class UserModel {
  final String name;
  final String email;
  UserModel({required this.name, required this.email});
}

class AuthService extends ChangeNotifier {
  UserModel? _user;

  UserModel? get user => _user;

  bool get isAuthenticated => _user != null;

  Future<void> login(String email, String password) async {
    print('Tentando fazer login...');
    await Future.delayed(const Duration(seconds: 1));

    if (email.isNotEmpty && password.isNotEmpty) {
      _user = UserModel(name: 'Ruan Vasconcelos', email: email);
      print('Login bem-sucedido!');
      notifyListeners();
    }
  }

  // Método de Logout
  Future<void> logout() async {
    _user = null;
    print('Usuário deslogado.');
    notifyListeners(); // Notifica os widgets que o estado mudou
  }
}