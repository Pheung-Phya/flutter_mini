import 'dart:developer';

import 'package:flutter_mini/data/datasources/product_remote_datesorces.dart';
import 'package:flutter_mini/data/models/product/product.dart';
import 'package:flutter_mini/domain/entities/product_entity.dart';
import 'package:flutter_mini/domain/repositories/product_repository.dart';

class ProductRepositoryImpl extends ProductRepository {
  final ProductRemoteDatesorces productRemoteDatesorces;

  // In-memory cache
  List<ProductEntity>? _cachedProducts;

  ProductRepositoryImpl(this.productRemoteDatesorces);

  @override
  Future<List<ProductEntity>> getAllProducts() async {
    if (_cachedProducts != null) {
      log('Returning products from cache');
      return _cachedProducts!;
    }
    log('Fetching products from remote');
    final products = await productRemoteDatesorces.getAllProducts();
    _cachedProducts = products;
    return products;
  }

  @override
  Future<Product> getProductById(int id) async {
    // Optional: check cache for product detail by id if needed
    final product = await productRemoteDatesorces.getProductById(id);
    log('log in repo impl : $product');
    return product;
  }

  // Optional: clear cache manually, e.g. on logout or pull-to-refresh
  void clearCache() {
    _cachedProducts = null;
  }
}
