part of 'cart_bloc.dart';

@immutable
sealed class CartEvent {}


class CartIntialEvent extends CartEvent {}


class CartRemoveEvent extends CartEvent {
  final ProductDataModel clickedProduct;

  CartRemoveEvent({required this.clickedProduct});
}

