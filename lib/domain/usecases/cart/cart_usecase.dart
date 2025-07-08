import 'package:flutter_mini/domain/entities/cart_item_entity.dart';
import 'package:flutter_mini/domain/repositories/cart_repository.dart';

class CartUsecase {
  final CartRepository repository;

  CartUsecase(this.repository);

  Future<List<CartItemEntity>> getAllCart() async {
    return await repository.getCartItems();
  }

  Future<void> addToCart(int productId) async {
    return await repository.addToCart(productId);
  }
}
