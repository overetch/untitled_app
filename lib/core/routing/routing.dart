import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:untitled/core/common/either.dart';
import 'package:untitled/core/common/usecase.dart';
import 'package:untitled/core/di/di_container.dart';
import 'package:untitled/feature/auth/domain/usecase/get_user.dart';
import 'package:untitled/feature/auth/presentation/screens/sign_in_screen.dart';
import 'package:untitled/feature/blog/presentation/screens/create_blog_screen.dart';
import 'package:untitled/presentation/main_screen.dart';

import '../../feature/auth/presentation/screens/sign_up_screen.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SignInScreen(),
      redirect: (context, state) async {
        final response = await DIContainer().get<GetUser>().call(NoParams());
        if (response.isRight()) {
          return '/main';
        }
        return state.fullPath;
      },
      routes: [
        GoRoute(
          path: '/signUp',
          builder: (context, state) => const SignUpScreen(),
        ),
      ],
    ),
    GoRoute(
      path: '/main',
      builder: (context, state) => const MainScreen(),
      routes: [
        GoRoute(
          path: '/blog_create',
          builder: (context, state) => const CreateBlogScreen(),
        ),
      ],
    ),
  ],
);

final String signInRoute = '/';
final String mainRoute = '/main';
final String blogCreateRoute = '$mainRoute/blog_create';
