import 'package:flutter/material.dart';

class ProductDetail extends StatelessWidget {
  final int? id;

  const ProductDetail({super.key, this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Product ID: $id')),
      body: Center(child: Text('Details for product ID: $id')),
    );
  }
}
