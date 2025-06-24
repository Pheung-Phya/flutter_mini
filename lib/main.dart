import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mini/bloc/auth_bloc.dart';
import 'package:flutter_mini/locator.dart';
import 'package:flutter_mini/presentation/pages/home_page.dart';
import 'package:flutter_mini/presentation/pages/login_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/':
            (context) => BlocProvider(
              create: (_) => sl<AuthBloc>(),
              child: const LoginPage(),
            ),
        '/home': (_) => const HomePage(),
      },
    );
  }
}
