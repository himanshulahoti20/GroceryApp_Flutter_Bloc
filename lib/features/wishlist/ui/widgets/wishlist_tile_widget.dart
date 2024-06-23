import 'package:flutter/material.dart';
import 'package:grocery_app/features/wishlist/bloc/wishlist_bloc.dart';
import 'package:grocery_app/models/product_data_model.dart';

class WishlistTileWidget extends StatefulWidget {
  const WishlistTileWidget(
      {super.key, required this.productDataModel, required this.wishlistBloc});

  final ProductDataModel productDataModel;
  final WishlistBloc wishlistBloc;

  @override
  State<WishlistTileWidget> createState() => _WishlistTileWidgetState();
}

class _WishlistTileWidgetState extends State<WishlistTileWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blueGrey.shade200,
      elevation: 5.0,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
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
              child: Expanded(
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
            ),
            IconButton(
              onPressed: () {
                widget.wishlistBloc.add(WishlistRemoveEvent(
                    clickedProduct: widget.productDataModel));
              },
              icon: Icon(
                Icons.delete,
                color: Colors.red.shade800,
              ),
            ),
            TextButton(onPressed: () {
              widget.wishlistBloc.add(WishlistAddedToCartEvent(
                      clickedProduct: widget.productDataModel));
            }, child: const Text('Add to cart',style: TextStyle(fontWeight: FontWeight.bold),))
          ],
        ),
      ),
    );
  }
}
