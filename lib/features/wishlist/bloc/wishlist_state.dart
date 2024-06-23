part of 'wishlist_bloc.dart';

@immutable
sealed class WishlistState {}


sealed class WishlistActionState extends WishlistState {}


final class WishlistInitial extends WishlistState {}

final class WishlistLoadingState extends WishlistState {}

class WishlistErrorState extends WishlistState {}

class WishlistSuccessState extends WishlistState {
  final List<ProductDataModel> wishlistItems;

  WishlistSuccessState({required this.wishlistItems});
  
}

final class WishlistItemRemovedState extends WishlistActionState {}

final class WishlistItemAddedToCartState extends WishlistActionState {}

