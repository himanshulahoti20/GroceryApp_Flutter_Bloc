import 'package:flutter/material.dart';
import 'package:grocery_app/features/cart/bloc/cart_bloc.dart';
import 'package:grocery_app/models/product_data_model.dart';

class CartTileWidget extends StatefulWidget {
  const CartTileWidget(
      {super.key, required this.productDataModel, required this.cartBloc});

  final ProductDataModel productDataModel;
  final CartBloc cartBloc;

  @override
  State<CartTileWidget> createState() => _CartTileWidgetState();
}

class _CartTileWidgetState extends State<CartTileWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blueGrey.shade200,
      elevation: 5.0,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image(
                height: 80,
                width: 80,
                image: NetworkImage(widget.productDataModel.image),
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              width: 130,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 5.0,
                  ),
                  RichText(
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    text: TextSpan(
                      text: 'Name: ',
                      style: TextStyle(
                          color: Colors.blueGrey.shade800, fontSize: 16.0),
                      children: [
                        TextSpan(
                            text: widget.productDataModel.name,
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  RichText(
                    maxLines: 1,
                    text: TextSpan(
                      text: 'Price: ' r"$ ",
                      style: TextStyle(
                          color: Colors.blueGrey.shade800, fontSize: 16.0),
                      children: [
                        TextSpan(
                          text: '${widget.productDataModel.price.toString()}\n',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  widget.cartBloc.add(CartRemoveEvent(clickedProduct: widget.productDataModel));
                });
              },
              icon: Icon(
                Icons.delete,
                color: Colors.red.shade800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
