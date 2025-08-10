import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/theme/theme.dart';
import 'feature/auth/presentation/screens/signup_screen.dart';
import 'init_dependencies.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Unknown',
      themeMode: ThemeMode.dark,
      theme: AppTheme.light().themeData,
      darkTheme: AppTheme.dark().themeData,
      home: SignupScreen(),
    );
  }
}
