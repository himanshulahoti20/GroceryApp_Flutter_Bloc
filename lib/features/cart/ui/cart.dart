import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/features/cart/bloc/cart_bloc.dart';
import 'package:grocery_app/features/cart/ui/widgets/cart_tile_widget.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  final CartBloc cartBloc = CartBloc();

  @override
  void initState() {
    super.initState();
    cartBloc.add(CartIntialEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart Items'),
        centerTitle: true,
      ),
      body: BlocConsumer<CartBloc, CartState>(
        bloc: cartBloc,
        listenWhen: (previous, current) => current is CartActionState,
        buildWhen: (previous, current) => current is! CartActionState,
        listener: (context, state) {
          if (state is CartProductRemoveState) {
            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Product Removed from Cart'),
              ),
            );
          }
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case const (CartLoadingState):
              return const Scaffold(
                  body: Center(child: CircularProgressIndicator()));
            case const (CartSuccessState):
              final successState = state as CartSuccessState;
              const content = Center(
                child: Text(
                  'Your Cart is Empty',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
              if (successState.cartItems.isNotEmpty) {
                return ListView.builder(
                  itemCount: successState.cartItems.length,
                  itemBuilder: (context, index) {
                    return CartTileWidget(
                        productDataModel: successState.cartItems[index],
                        cartBloc: cartBloc);
                  },
                );
              } else {
                return content;
              }
            case const (CartErrorState):
              return const Scaffold(
                body: Center(
                  child: Text('Error'),
                ),
              );
            default:
              return const SizedBox();
          }
        },
      ),
    );
  }
}
