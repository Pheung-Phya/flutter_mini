import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mini/bloc/cart/bloc/cart_bloc.dart';
import 'package:flutter_mini/bloc/cart/bloc/cart_event.dart';
import 'package:flutter_mini/bloc/cart/bloc/cart_state.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Load cart items on page load
    context.read<CartBloc>().add(LoadCart());

    return Scaffold(
      appBar: AppBar(title: const Text('My Cart')),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CartLoaded) {
            if (state.cartItems.isEmpty) {
              return const Center(child: Text('Your cart is empty.'));
            }
            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: state.cartItems.length,
              separatorBuilder: (_, __) => const Divider(),
              itemBuilder: (context, index) {
                final item = state.cartItems[index];
                final product = item.product;

                return ListTile(
                  leading:
                      product.image != null
                          ? Image.network(
                            'http://10.0.2.2:8000${product.image}',
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          )
                          : const Icon(Icons.image_not_supported),
                  title: Text(product.name),
                  subtitle: Text(
                    'Quantity: ${item.quantity}\nPrice: \$${product.price}',
                  ),
                  isThreeLine: true,
                );
              },
            );
          } else if (state is CartError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
