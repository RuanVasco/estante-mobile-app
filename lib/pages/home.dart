import 'dart:developer' as developer;

import 'package:estante/models/api_response_model.dart';
import 'package:estante/models/ad_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../services/api_service.dart';
import '../services/auth_service.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<AdModel> _ads = [];
  final ApiService _apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _fetchAds();
  }

  Future<void> _fetchAds() async {
    try {
      final ApiResponseModel decodedData = await _apiService.get('/ads');

      developer.log('${decodedData.body}');

      // final List<BookAd> fetchedAds = (decodedData['data'] as List)
      //     .map((data) => BookAd(name: data['name']))
      //     .toList();

      // setState(() {
      //   _bookAds = fetchedAds;
      //   _isLoading = false;
      //   _errorMessage = null;
      // });

    } catch (e) {
      developer.log('Ocorreu um erro: $e', name: 'API Call', error: e);
      // setState(() {
      //   _errorMessage = e.toString();
      //   _isLoading = false;
      // });
    }
  }

  @override
  Widget build(BuildContext context) {
    final authService = context.watch<AuthService>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Estante"),
        actions: [
          PopupMenuButton<String>(
            onSelected: (String result) {
              if (result == 'profile') {
                context.go('/profile/2');
              } else if (result == 'logout') {
                authService.logout();
              } else if (result == 'login') {
                context.go('/login');
              } else if (result == 'register') {
                context.go('/register');
              }
            },
            itemBuilder: (BuildContext context) {
              if (authService.isAuthenticated) {
                return <PopupMenuEntry<String>>[
                  const PopupMenuItem<String>(
                    value: 'profile',
                    child: Row(
                      children: [
                        Icon(Icons.person, color: Colors.black54),
                        SizedBox(width: 8),
                        Text('Meu Perfil'),
                      ],
                    ),
                  ),
                  const PopupMenuItem<String>(
                    value: 'logout',
                    child: Row(
                      children: [
                        Icon(Icons.logout, color: Colors.black54),
                        SizedBox(width: 8),
                        Text('Logout'),
                      ],
                    ),
                  ),
                ];
              } else {
                return <PopupMenuEntry<String>>[
                  const PopupMenuItem<String>(
                    value: 'login',
                    child: Row(
                      children: [
                        Icon(Icons.login, color: Colors.black54),
                        SizedBox(width: 8),
                        Text('Login'),
                      ],
                    ),
                  ),
                  const PopupMenuItem<String>(
                    value: 'register',
                    child: Row(
                      children: [
                        Icon(Icons.person_add, color: Colors.black54),
                        SizedBox(width: 8),
                        Text('Registrar-se'),
                      ],
                    ),
                  ),
                ];
              }
            },
            icon: const Icon(Icons.account_circle),
            tooltip: 'Opções de Perfil',
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _ads.length,
        itemBuilder: (context, index) {
          final ad = _ads[index];
          return ListTile(
            title: Text(ad.book.title),
            leading: const Icon(Icons.book),
            onTap: () {},
          );
        },
      ),
      floatingActionButton: PopupMenuButton<String>(
        tooltip: 'Abrir menu de opções',
        onSelected: (String result) {
          switch (result) {
            case 'opcao1':
              print('Opção 1 selecionada');
              break;
            case 'opcao2':
              print('Opção 2 selecionada');
              break;
          }
        },

        itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
          const PopupMenuItem<String>(
            value: 'opcao1',
            child: Row(
              children: [
                Icon(Icons.add_comment, color: Colors.black54),
                SizedBox(width: 8),
                Text('Adicionar Comentário'),
              ],
            ),
          ),
          const PopupMenuItem<String>(
            value: 'opcao2',
            child: Row(
              children: [
                Icon(Icons.camera_alt, color: Colors.black54),
                SizedBox(width: 8),
                Text('Tirar Foto'),
              ],
            ),
          ),
        ],

        child: FloatingActionButton(
          onPressed: null,
          child: const Icon(Icons.menu),
        ),
      ),
    );
  }
}