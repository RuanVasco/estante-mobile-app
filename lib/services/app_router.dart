import 'package:estante/pages/home.dart';
import 'package:estante/pages/login.dart';
import 'package:estante/pages/profile.dart';
import 'package:estante/services/auth_service.dart';
import 'package:go_router/go_router.dart';

import '../pages/register.dart';

class AppRouter {
  final AuthService authService;

  AppRouter({required this.authService});

  late final GoRouter router = GoRouter(
    refreshListenable: authService,

    initialLocation: '/',

    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
          path: '/register',
          builder: (context, state) => const RegisterPage(),
      ),
      GoRoute(
        path: '/',
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: '/profile/:id',
        builder: (context, state) {
        try {
          final String idString = state.pathParameters['id']!;

          final int id = int.parse(idString);

          return ProfilePage(id: id);
        } catch (e) {
          return const HomePage();
          }
        },
      )
    ],
  );
}