import 'package:flutter_mini/domain/entities/product_entity.dart';

class CartItemEntity {
  final int quantity;
  final ProductEntity product;

  CartItemEntity({required this.quantity, required this.product});
}
