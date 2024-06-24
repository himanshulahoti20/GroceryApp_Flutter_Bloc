import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:grocery_app/data/cart_items.dart';
import 'package:grocery_app/data/wishlist_items.dart';
import 'package:grocery_app/models/product_data_model.dart';
import 'package:meta/meta.dart';

part 'wishlist_event.dart';
part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  WishlistBloc() : super(WishlistInitial()) {
    on<WishlistInitialEvent>(wishlistInitialEvent);
    on<WishlistRemoveEvent>(wishlistRemoveEvent);
    on<WishlistAddedToCartEvent>(wishlistAddedToCartEvent);

  }

  FutureOr<void> wishlistAddedToCartEvent(WishlistAddedToCartEvent event, Emitter<WishlistState> emit) {
    wishlistItems.remove(event.clickedProduct);
    cartItems.add(event.clickedProduct);
     emit(WishlistItemAddedToCartState());
    emit(WishlistSuccessState(wishlistItems: wishlistItems));
  }

  FutureOr<void> wishlistRemoveEvent(WishlistRemoveEvent event, Emitter<WishlistState> emit) {
        wishlistItems.remove(event.clickedProduct);
        emit(WishlistItemRemovedState());
    emit(WishlistSuccessState(wishlistItems: wishlistItems));
  }

  FutureOr<void> wishlistInitialEvent(WishlistInitialEvent event, Emitter<WishlistState> emit) async {
    emit(WishlistLoadingState());
    await Future.delayed(const Duration(seconds: 1));
    emit(WishlistSuccessState(wishlistItems: wishlistItems));
  }
}
