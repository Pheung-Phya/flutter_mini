import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter_mini/core/network/api_client.dart';
import 'package:flutter_mini/data/models/product/product.dart';

class ProductRemoteDatesorces {
  final ApiClient apiClient;

  ProductRemoteDatesorces(this.apiClient);

  Future<List<Product>> getAllProducts() async {
    final response = await apiClient.client.get('/product-home');
    final List<dynamic> rawData = response.data['data'];

    // Convert safely for compute
    final List<Map<String, dynamic>> safeData = List<Map<String, dynamic>>.from(
      rawData,
    );

    return compute(parseProductList, safeData);
  }

  // This runs in a background isolate
  static List<Product> parseProductList(List<Map<String, dynamic>> jsonList) {
    return jsonList.map((json) => Product.fromJson(json)).toList();
  }

  Future<Product> getProductById(int id) async {
    final response = await apiClient.client.get('/product/$id');
    log('from api : ${response.data}');
    final product = Product.fromJson(response.data['data']);
    log('log product $product');
    return product;
  }
}
