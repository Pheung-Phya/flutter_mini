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
}
