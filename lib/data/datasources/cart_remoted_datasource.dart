import 'package:flutter_mini/core/network/api_client.dart';
import 'package:flutter_mini/data/models/cart/cart_item.dart';

class CartRemoteDataSource {
  final ApiClient api;

  CartRemoteDataSource(this.api);

  Future<List<CartItem>> getCartItems() async {
    final response = await api.client.get('/cart');

    final items = response.data['data']['cart_items'] as List;
    return items.map((e) => CartItem.fromJson(e)).toList();
  }

  Future<void> addToCart(int productId) async {
    await api.client.post('/cart', data: {'product_id': productId});
  }
}
