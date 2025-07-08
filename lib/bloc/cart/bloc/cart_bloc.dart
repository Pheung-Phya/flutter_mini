import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mini/bloc/cart/bloc/cart_event.dart';
import 'package:flutter_mini/bloc/cart/bloc/cart_state.dart';
import 'package:flutter_mini/domain/entities/cart_item_entity.dart';
import 'package:flutter_mini/domain/usecases/cart/cart_usecase.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartUsecase cartUseCase;

  CartBloc({required this.cartUseCase}) : super(CartInitial()) {
    on<LoadCart>(_onLoadCart);
    on<AddToCart>(_onAddToCart);
  }

  Future<void> _onLoadCart(LoadCart event, Emitter<CartState> emit) async {
    emit(CartLoading());
    try {
      final List<CartItemEntity> cartItems = await cartUseCase.getAllCart();
      emit(CartLoaded(cartItems));
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  Future<void> _onAddToCart(AddToCart event, Emitter<CartState> emit) async {
    try {
      await cartUseCase.addToCart(event.productId);
      add(LoadCart());
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }
}
