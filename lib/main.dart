import 'package:flutter/material.dart';

import 'package:untitled/core/routing/routing.dart';
import 'package:untitled/core/theme/theme.dart';
import 'package:untitled/init_dependencies.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Unknown',
      themeMode: ThemeMode.dark,
      theme: AppTheme.light().themeData,
      darkTheme: AppTheme.dark().themeData,
      routerConfig: router,
    );
  }
}
