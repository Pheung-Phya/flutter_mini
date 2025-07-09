import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mini/bloc/product/bloc/product_bloc.dart';
import 'package:flutter_mini/domain/entities/product_entity.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<ProductBloc>().add(GetAllProducts());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Our Products'),
        backgroundColor: Colors.deepPurple,
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        buildWhen: (previous, current) {
          // Avoid rebuilding on unnecessary states
          return current is! ProductLoading;
        },
        builder: (context, state) {
          if (state is ProductLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProductError) {
            return Center(child: Text('Error: ${state.message}'));
          } else if (state is ProductLoaded) {
            final products = state.products;

            if (products.isEmpty) {
              return const Center(child: Text('No products found'));
            }

            return _buildProductGrid(products);
          } else {
            return const SizedBox(); // Unknown or initial state
          }
        },
      ),
    );
  }

  Widget _buildProductGrid(List<ProductEntity> products) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: MasonryGridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        itemCount: products.length,
        itemBuilder: (context, index) {
          final p = products[index];
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/product-detail', arguments: p.id);
            },
            child: _buildProductCard(p),
          );
        },
      ),
    );
  }

  Widget _buildProductCard(ProductEntity p) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
            child:
                p.image != null
                    ? CachedNetworkImage(
                      imageUrl: 'http://10.0.2.2:8000${p.image!}',
                      placeholder:
                          (context, url) => const Padding(
                            padding: EdgeInsets.all(20),
                            child: Center(child: CircularProgressIndicator()),
                          ),
                      errorWidget:
                          (context, url, error) => const Icon(Icons.error),
                      fit: BoxFit.cover,
                      width: double.infinity,
                    )
                    : Container(
                      height: 120,
                      width: double.infinity,
                      color: Colors.grey.shade200,
                      child: const Icon(Icons.image_not_supported, size: 50),
                    ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              p.name,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              '\$${p.price.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 14, color: Colors.deepPurple),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: ElevatedButton(
              onPressed: () {
                // TODO: Add to Cart functionality here
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                minimumSize: const Size(double.infinity, 36),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text('Add', style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}
