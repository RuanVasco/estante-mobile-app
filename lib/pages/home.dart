import 'dart:convert';
import 'dart:developer' as developer;

import 'package:estante/entities/book_ad.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../services/api_service.dart';
import '../services/auth_service.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});
  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<BookAd> _bookAds = [];
  final ApiService _apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _fetchAds();
    _setupInitialBookAds();
  }

  Future<void> _fetchAds() async {
    try {
      final decodedData = await _apiService.get('/ads');

      developer.log('Dados Recebidos: $decodedData', name: 'API Call');

      final List<BookAd> fetchedAds = (decodedData['data'] as List)
          .map((data) => BookAd(name: data['name']))
          .toList();

      setState(() {
        _bookAds = fetchedAds;
      //   _isLoading = false;
      //   _errorMessage = null;
      });

    } catch (e) {
      developer.log('Ocorreu um erro: $e', name: 'API Call', error: e);
      // setState(() {
      //   _errorMessage = e.toString();
      //   _isLoading = false;
      // });
    }
  }

  void _setupInitialBookAds() {
    setState(() {
      _bookAds.addAll([
        const BookAd(name: 'O Senhor dos Anéis'),
        const BookAd(name: 'Duna'),
        const BookAd(name: 'Fundação'),
      ]);
    });
  }

  void _addBookAd() {
    setState(() {
      _bookAds.add(BookAd(name: 'Novo Livro #${_bookAds.length + 1}'));
    });
  }

  @override
  Widget build(BuildContext context) {
    final authService = context.watch<AuthService>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
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
        itemCount: _bookAds.length,
        itemBuilder: (context, index) {
          final bookAd = _bookAds[index];
          return ListTile(
            title: Text(bookAd.name),
            leading: const Icon(Icons.book),
            onTap: () {},
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addBookAd,
        tooltip: 'Adicionar Anúncio',
        child: const Icon(Icons.add),
      ),
    );
  }
}