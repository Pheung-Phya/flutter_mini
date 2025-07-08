import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mini/bloc/auth/auth_bloc.dart';
import 'package:flutter_mini/bloc/cart/bloc/cart_bloc.dart';
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
        BlocProvider<CartBloc>(create: (_) => sl<CartBloc>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/':
              return MaterialPageRoute(builder: (_) => const SplashPage());

            case '/menu':
              return MaterialPageRoute(builder: (_) => MenuPage());

            case '/login':
              return MaterialPageRoute(builder: (_) => LoginPage());

            case '/home':
              return MaterialPageRoute(builder: (_) => HomePage());

            case '/product-detail':
              final id = settings.arguments as int;
              return MaterialPageRoute(builder: (_) => ProductDetail(id: id));

            default:
              return MaterialPageRoute(
                builder:
                    (_) => Scaffold(
                      body: Center(
                        child: Text('No route defined for ${settings.name}'),
                      ),
                    ),
              );
          }
        },
      ),
    );
  }
}
