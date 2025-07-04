import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mini/bloc/auth/auth_bloc.dart';
import 'package:flutter_mini/bloc/product/bloc/product_bloc.dart';
import 'package:flutter_mini/locator.dart';
import 'package:flutter_mini/presentation/product_pages/home_page.dart';
import 'package:flutter_mini/presentation/authpages/login_page.dart';
import 'package:flutter_mini/presentation/authpages/splash_page.dart';
import 'package:flutter_mini/presentation/product_pages/menu_page.dart';
import 'package:flutter_mini/presentation/product_pages/product_detail.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  init(); // initialize GetIt
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (_) => sl<AuthBloc>()),
        BlocProvider<ProductBloc>(
          create: (_) => sl<ProductBloc>()..add(GetAllProducts()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (_) => const SplashPage(),
          '/menu': (_) => MenuPage(),
          '/login': (_) => LoginPage(),
          '/home': (_) => HomePage(),
          '/product-detail': (context) {
            final args = ModalRoute.of(context)!.settings.arguments as int;
            return ProductDetail(id: args);
          },
        },
      ),
    );
  }
}
