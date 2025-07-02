part of 'product_bloc.dart';

sealed class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

final class GetAllProducts extends ProductEvent {}

final class GetProductById extends ProductEvent {
  final int id;
  const GetProductById({required this.id});
}
