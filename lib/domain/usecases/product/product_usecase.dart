import 'dart:developer';

import 'package:flutter_mini/domain/entities/product_entity.dart';
import 'package:flutter_mini/domain/repositories/product_repository.dart';

class ProductUsecase {
  ProductRepository productRepository;

  ProductUsecase(this.productRepository);

  Future<List<ProductEntity>> getAllProduct() async {
    return await productRepository.getAllProducts();
  }

  Future<ProductEntity> getProductById(int id) async {
    return await productRepository.getProductById(id);
  }
}
