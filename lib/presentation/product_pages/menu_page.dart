import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mini/presentation/product_pages/home_page.dart';
import 'package:flutter_mini/presentation/profile_page/profile_page.dart';

// ignore: must_be_immutable
class MenuPage extends StatelessWidget {
  MenuPage({super.key});

  List<Widget> list = [
    HomePage(),
    Container(color: Colors.pink),
    Container(color: Colors.black),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NavigationCubit(),
      child: BlocBuilder<NavigationCubit, int>(
        builder: (contex, index) {
          return Scaffold(
            body: list[index],
            bottomNavigationBar: NavigationBar(
              onDestinationSelected:
                  (value) => contex.read<NavigationCubit>().pageChange(value),
              selectedIndex: index,
              labelBehavior:
                  NavigationDestinationLabelBehavior.onlyShowSelected,
              destinations: [
                NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
                NavigationDestination(
                  icon: Icon(Icons.shopping_cart),
                  label: 'Home',
                ),
                NavigationDestination(
                  icon: Icon(Icons.settings),
                  label: 'Home',
                ),
                NavigationDestination(
                  icon: Icon(Icons.person),
                  label: 'Profile',
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class NavigationCubit extends Cubit<int> {
  NavigationCubit() : super(0);
  void pageChange(int index) => emit(index);
}
