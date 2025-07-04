part of 'product_bloc.dart';

sealed class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object?> get props => [];
}

final class ProductInitial extends ProductState {}

final class ProductLoading extends ProductState {}

final class ProductLoaded extends ProductState {
  final List<ProductEntity> products;

  const ProductLoaded(this.products);

  @override
  List<Object?> get props => [products];
}

// Failure state with error message
final class ProductError extends ProductState {
  final String message;

  const ProductError(this.message);

  @override
  List<Object?> get props => [message];
}

final class ProductDetailById extends ProductState {
  final ProductEntity product;
  const ProductDetailById(this.product);
  @override
  List<Object?> get props => [product];
}
