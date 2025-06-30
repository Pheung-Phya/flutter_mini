import 'package:flutter/material.dart';
import 'package:flutter_mini/data/datasources/product_remote_datesorces.dart';
import 'package:flutter_mini/data/models/product/product.dart';
import 'package:flutter_mini/locator.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final ProductRemoteDatesorces pr = sl<ProductRemoteDatesorces>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Product>>(
        future: pr.getAllProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No products found'));
          }

          final products = snapshot.data!;

          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              final p = products[index];
              return ListTile(
                leading:
                    p.image != null
                        ? Image.network(
                          p.image!,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        )
                        : const Icon(Icons.image_not_supported),
                title: Text(p.name),
                subtitle: Text('\$${p.price.toStringAsFixed(2)}'),
              );
            },
          );
        },
      ),
    );
  }
}
