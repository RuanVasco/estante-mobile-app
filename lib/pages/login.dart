import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Scaffold é um widget que implementa a estrutura básica de layout do Material Design.
    // Ele fornece uma AppBar, um corpo (body) e outras funcionalidades como gavetas (drawers).
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        backgroundColor: Colors.blueAccent, // Cor da barra superior
        foregroundColor: Colors.white, // Cor do texto do título
      ),
      // O corpo da tela
      body: Padding(
        // Adiciona um espaçamento de 16 pixels em todas as bordas
        padding: const EdgeInsets.all(16.0),
        // Center alinha seu filho (child) ao centro da tela
        child: Center(
          // Column organiza seus filhos verticalmente
          child: Column(
            // Alinha os widgets ao centro verticalmente
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Texto de boas-vindas
              const Text(
                'Bem-vindo de volta!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),

              // Adiciona um espaço vertical de 24 pixels
              const SizedBox(height: 24),

              // Campo de texto para o Email
              TextField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: 'Digite seu email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: const Icon(Icons.email),
                ),
                keyboardType: TextInputType.emailAddress,
              ),

              const SizedBox(height: 16),

              // Campo de texto para a Senha
              TextField(
                decoration: InputDecoration(
                  labelText: 'Senha',
                  hintText: 'Digite sua senha',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: const Icon(Icons.lock),
                ),
                obscureText: true, // Esconde o texto da senha
              ),

              const SizedBox(height: 24),

              // Botão de Login
              ElevatedButton(
                onPressed: () {
                  // A lógica de login seria adicionada aqui
                  print('Botão de login pressionado!');
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50), // Faz o botão ocupar a largura total
                  backgroundColor: Colors.blueAccent,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('Entrar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}