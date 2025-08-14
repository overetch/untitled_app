import 'package:go_router/go_router.dart';
import 'package:untitled/feature/auth/presentation/screens/sign_in_screen.dart';

import '../../feature/auth/presentation/screens/sign_up_screen.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => SignInScreen(),
      routes: [
        GoRoute(path: '/signUp', builder: (context, state) => SignUpScreen()),
      ],
    ),
  ],
);
