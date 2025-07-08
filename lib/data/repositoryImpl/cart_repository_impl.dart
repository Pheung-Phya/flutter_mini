import 'package:flutter_mini/data/datasources/cart_remoted_datasource.dart';
import 'package:flutter_mini/domain/entities/cart_item_entity.dart';
import 'package:flutter_mini/domain/repositories/cart_repository.dart';

class CartRepositoryImpl implements CartRepository {
  final CartRemoteDataSource remoteDataSource;

  CartRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<CartItemEntity>> getCartItems() async {
    final items = await remoteDataSource.getCartItems();
    return items;
  }

  @override
  Future<void> addToCart(int productId) {
    return remoteDataSource.addToCart(productId);
  }
}
