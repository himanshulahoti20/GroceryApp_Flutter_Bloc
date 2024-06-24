part of 'wishlist_bloc.dart';

@immutable
abstract class WishlistEvent {}

class WishlistInitialEvent extends WishlistEvent {}

class WishlistRemoveEvent extends WishlistEvent {
   final ProductDataModel clickedProduct;

  WishlistRemoveEvent({required this.clickedProduct});

}

class WishlistAddedToCartEvent extends WishlistEvent {
   final ProductDataModel clickedProduct;

  WishlistAddedToCartEvent({required this.clickedProduct});

}

