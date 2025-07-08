import 'package:flutter_mini/data/models/product/product.dart';
import 'package:flutter_mini/domain/entities/cart_item_entity.dart';

class CartItem extends CartItemEntity {
  CartItem({required int quantity, required Product product})
    : super(quantity: quantity, product: product);

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      quantity:
          json['quantity'] is int
              ? json['quantity']
              : int.tryParse(json['quantity'].toString()) ?? 0,
      product: Product.fromJson(json['product']),
    );
  }

  CartItemEntity toCartItemEntity() {
    return CartItemEntity(quantity: quantity, product: product);
  }
}
