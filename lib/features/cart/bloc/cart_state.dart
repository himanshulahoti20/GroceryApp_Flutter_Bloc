part of 'cart_bloc.dart';

@immutable
sealed class CartState {}

sealed class CartActionState extends CartState {}

 class CartInitial extends CartState {}

 class CartLoadingState extends CartState {}

class CartSuccessState extends CartState {
  final List<ProductDataModel> cartItems;

  CartSuccessState({required this.cartItems});
  
}

class CartErrorState extends CartState {}
class CartProductRemoveState extends CartActionState {}