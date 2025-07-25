import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_mini/domain/entities/product_entity.dart';
import 'package:flutter_mini/domain/usecases/product/product_usecase.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductUsecase productRepository;

  ProductBloc(this.productRepository) : super(ProductInitial()) {
    on<GetAllProducts>(_onLoadAllProduct);
    on<GetProductById>(_onLoadDetailProduct);
  }

  Future<void> _onLoadAllProduct(
    GetAllProducts even,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoading());
    try {
      final products = await productRepository.getAllProduct();
      emit(ProductLoaded(products));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  Future<void> _onLoadDetailProduct(
    GetProductById even,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoading());
    try {
      final product = await productRepository.getProductById(even.id);
      log('log in bloc detail $product');
      emit(ProductDetailById(product));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }
}
