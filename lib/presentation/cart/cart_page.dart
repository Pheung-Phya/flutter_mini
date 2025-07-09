import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mini/bloc/cart/bloc/cart_bloc.dart';
import 'package:flutter_mini/bloc/cart/bloc/cart_event.dart';
import 'package:flutter_mini/bloc/cart/bloc/cart_state.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  // Keep track of throttled product IDs (buttons temporarily disabled)
  final Set<int> _throttledProducts = {};

  void _onAddPressed(int productId) {
    if (_throttledProducts.contains(productId)) return;

    setState(() {
      _throttledProducts.add(productId);
    });

    context.read<CartBloc>().add(AddToCart(productId));

    // Disable button for 300ms to throttle rapid taps
    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        _throttledProducts.remove(productId);
      });
    });
  }

  void _onRemovePressed(int productId, int newQuantity) {
    if (_throttledProducts.contains(productId)) return;

    setState(() {
      _throttledProducts.add(productId);
    });

    context.read<CartBloc>().add(
      UpdateCartQuantity(productId: productId, quantity: newQuantity),
    );

    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        _throttledProducts.remove(productId);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // Load cart items when page opens
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
                final isThrottled = _throttledProducts.contains(product.id);

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
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Price: \$${product.price.toStringAsFixed(2)}'),
                      const SizedBox(height: 8),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize:
                        MainAxisSize.min, // avoid infinite width error
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove_circle_outline),
                        onPressed:
                            (item.quantity > 1 && !isThrottled)
                                ? () => _onRemovePressed(
                                  product.id,
                                  item.quantity - 1,
                                )
                                : null,
                      ),
                      Text('${item.quantity}'),
                      IconButton(
                        icon: const Icon(Icons.add_circle_outline),
                        onPressed:
                            (item.quantity < product.stock && !isThrottled)
                                ? () => _onAddPressed(product.id)
                                : () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Only ${product.stock} in stock!',
                                      ),
                                    ),
                                  );
                                },
                      ),
                    ],
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

      // Order Button with Total Price
      bottomNavigationBar: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartLoaded && state.cartItems.isNotEmpty) {
            final total = state.cartItems.fold<double>(
              0,
              (sum, item) => sum + (item.product.price * item.quantity),
            );

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Total: \$${total.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // TODO: Place order logic here
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Order placed successfully!"),
                          ),
                        );
                      },
                      icon: const Icon(Icons.shopping_cart_checkout),
                      label: const Text('Order Now'),
                    ),
                  ),
                ],
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
