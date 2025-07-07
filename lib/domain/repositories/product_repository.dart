import 'package:flutter_mini/data/models/product/product.dart';
import 'package:flutter_mini/domain/entities/product_entity.dart';

abstract class ProductRepository {
  Future<List<ProductEntity>> getAllProducts();
  Future<Product> getProductById(int id);
}
