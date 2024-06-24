import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:grocery_app/data/cart_items.dart';
import 'package:grocery_app/models/product_data_model.dart';
import 'package:meta/meta.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<CartIntialEvent>(cartIntialEvent);
    on<CartRemoveEvent>(cartRemoveEvent);
  }

  FutureOr<void> cartRemoveEvent(
      CartRemoveEvent event, Emitter<CartState> emit) {
    cartItems.remove(event.clickedProduct);
    emit(CartProductRemoveState());
    emit(CartSuccessState(cartItems: cartItems));
  }

  FutureOr<void> cartIntialEvent(
      CartIntialEvent event, Emitter<CartState> emit) async {
    emit(CartLoadingState());
    await Future.delayed(const Duration(seconds: 1));
    emit(CartSuccessState(cartItems: cartItems));
  }
}
