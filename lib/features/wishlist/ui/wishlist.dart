import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/features/cart/ui/cart.dart';
import 'package:grocery_app/features/wishlist/bloc/wishlist_bloc.dart';
import 'package:grocery_app/features/wishlist/ui/widgets/wishlist_tile_widget.dart';

class Wishlist extends StatefulWidget {
  const Wishlist({super.key});

  @override
  State<Wishlist> createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {
  final WishlistBloc wishlistBloc = WishlistBloc();

  @override
  void initState() {
    super.initState();
    wishlistBloc.add(WishlistInitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wishlist'),
        centerTitle: true,
      ),
      body: BlocConsumer<WishlistBloc, WishlistState>(
        bloc: wishlistBloc,
        listenWhen: (previous, current) => current is WishlistActionState,
        buildWhen: (previous, current) => current is! WishlistActionState,
        listener: (context, state) async {
          if (state is WishlistItemAddedToCartState) {
            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Product Added to Cart'),
              ),
            );
            await Future.delayed(const Duration(seconds: 1));
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const Cart(),
              ),
            );
          } else if (state is WishlistItemRemovedState) {
            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Product Removed from Wishlist'),
              ),
            );
          }
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case const (WishlistLoadingState):
              return const Center(child: CircularProgressIndicator());
            case const (WishlistSuccessState):
              final successState = state as WishlistSuccessState;
              if (successState.wishlistItems.isNotEmpty) {
                return ListView.builder(
                  itemCount: successState.wishlistItems.length,
                  itemBuilder: (context, index) {
                    return WishlistTileWidget(
                      productDataModel: successState.wishlistItems[index],
                      wishlistBloc: wishlistBloc,
                    );
                  },
                );
              } else {
                return const Center(
                  child: Text(
                    'Your Wishlist is Empty',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              }
            case const (WishlistErrorState):
              return const Center(
                child: Text('Error'),
              );
            default:
              return const SizedBox();
          }
        },
      ),
    );
  }
}
