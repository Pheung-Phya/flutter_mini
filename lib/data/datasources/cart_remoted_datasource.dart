import 'dart:developer';

import 'package:flutter_mini/core/network/api_client.dart';
import 'package:flutter_mini/data/models/cart/cart_item.dart';

class CartRemoteDataSource {
  final ApiClient api;

  CartRemoteDataSource(this.api);

  Future<List<CartItem>> getCartItems() async {
    try {
      log('[getCartItems] fetching...');
      final response = await api.client.get('/cart');
      final data = response.data;
      if (data == null ||
          data['data'] == null ||
          data['data']['cart_items'] == null) {
        throw Exception('Invalid response from server');
      }

      final items = data['data']['cart_items'] as List;
      log('[getCartItems] items: $items');
      return items.map((e) => CartItem.fromJson(e)).toList();
    } catch (e) {
      log('[getCartItems] Unknown error: $e');
      throw Exception('Unexpected error occurred');
    }
  }

  Future<void> addToCart(int productId) async {
    await api.client.post('/cart', data: {'product_id': productId});
  }
}
