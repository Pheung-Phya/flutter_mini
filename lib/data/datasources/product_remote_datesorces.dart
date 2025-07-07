import 'dart:developer';
import 'package:flutter_mini/core/network/api_client.dart';
import 'package:flutter_mini/data/models/product/product.dart';

class ProductRemoteDatesorces {
  final ApiClient apiClient;

  ProductRemoteDatesorces(this.apiClient);

  Future<List<Product>> getAllProducts() async {
    final response = await apiClient.client.get('/product-home');

    final List<dynamic> productListJson = response.data['data'];
    log('$productListJson');
    final products =
        productListJson
            .map((json) => Product.fromJson(json as Map<String, dynamic>))
            .toList();
    return products;
  }

  Future<Product> getProductById(int id) async {
    final response = await apiClient.client.get('/product/$id');
    log('from api : ${response.data}');
    final product = Product.fromJson(response.data['data']);
    log('log product $product');
    return product;
  }
}
