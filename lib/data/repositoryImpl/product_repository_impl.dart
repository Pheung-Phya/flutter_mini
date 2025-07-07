import 'dart:developer';

import 'package:flutter_mini/data/datasources/product_remote_datesorces.dart';
import 'package:flutter_mini/data/models/product/product.dart';
import 'package:flutter_mini/domain/entities/product_entity.dart';
import 'package:flutter_mini/domain/repositories/product_repository.dart';

class ProductRepositoryImpl extends ProductRepository {
  final ProductRemoteDatesorces productRemoteDatesorces;
  ProductRepositoryImpl(this.productRemoteDatesorces);

  @override
  Future<List<ProductEntity>> getAllProducts() async {
    final product = await productRemoteDatesorces.getAllProducts();
    return product;
  }

  @override
  Future<Product> getProductById(int id) async {
    final product = await productRemoteDatesorces.getProductById(id);
    log('log in repo impl : $product');
    return product;
  }
}
