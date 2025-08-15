import 'package:flutter/material.dart';

// Modelo simples para representar o usuário logado
class UserModel {
  final String name;
  final String email;
  UserModel({required this.name, required this.email});
}

// O nosso "AuthContext". Ele gerencia o estado de autenticação.
class AuthService extends ChangeNotifier {
  UserModel? _user;

  UserModel? get user => _user;

  // Um getter simples para verificar se o usuário está logado
  bool get isAuthenticated => _user != null;

  // Método de Login (simulado)
  Future<void> login(String email, String password) async {
    // Em um app real, aqui você faria uma chamada de API
    print('Tentando fazer login...');
    await Future.delayed(const Duration(seconds: 1)); // Simula latência de rede

    // Lógica de login fake
    if (email.isNotEmpty && password.isNotEmpty) {
      _user = UserModel(name: 'Ruan Vasconcelos', email: email);
      print('Login bem-sucedido!');
      notifyListeners(); // Notifica os widgets que o estado mudou
    }
  }

  // Método de Logout
  Future<void> logout() async {
    _user = null;
    print('Usuário deslogado.');
    notifyListeners(); // Notifica os widgets que o estado mudou
  }
}