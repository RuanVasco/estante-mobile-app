import 'package:estante/pages/home.dart';
import 'package:estante/pages/login.dart';
import 'package:estante/pages/profile.dart';
import 'package:estante/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  final AuthService authService;

  AppRouter({required this.authService});

  late final GoRouter router = GoRouter(
    refreshListenable: authService,

    initialLocation: '/login',

    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const HomePage(title: 'Home'),
      ),
      GoRoute(
        path: '/profile/:id',
        builder: (context, state) {
        try {
          final String idString = state.pathParameters['id']!;

          final int id = int.parse(idString);

          return ProfilePage(id: id);
        } catch (e) {
          print('Error parsing profile ID: $e');
          return const HomePage(title: 'Home');
          }
        },
      )
    ],

    redirect: (BuildContext context, GoRouterState state) {
      final isAuthenticated = authService.isAuthenticated;
      final isLoggingIn = state.matchedLocation == '/login';

      if (!isAuthenticated && !isLoggingIn) {
        return '/login';
      }

      if (isAuthenticated && isLoggingIn) {
        return '/home';
      }

      return null;
    },
  );
}