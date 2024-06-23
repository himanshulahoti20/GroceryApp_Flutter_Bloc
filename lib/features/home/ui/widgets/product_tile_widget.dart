import 'package:flutter/material.dart';
import 'package:grocery_app/features/home/bloc/home_bloc.dart';
import 'package:grocery_app/models/product_data_model.dart';

class ProductTileWidget extends StatelessWidget {
  const ProductTileWidget(
      {super.key, required this.productDataModel, required this.homeBloc});

  final ProductDataModel productDataModel;
  final HomeBloc homeBloc;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200,
            width: double.maxFinite,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                filterQuality: FilterQuality.high,
                image: NetworkImage(
                  productDataModel.image,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            productDataModel.name,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            productDataModel.description,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "\$${productDataModel.price}",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      homeBloc.add(
                        HomeProductWishlistButtonClickedEvent(
                          clickedProduct: productDataModel,
                        ),
                      );
                    },
                    icon: const Icon(Icons.favorite_border),
                  ),
                  IconButton(
                    onPressed: () {
                      homeBloc.add(
                        HomeProductCartButtonClickedEvent(
                          clickedProduct: productDataModel,
                        ),
                      );
                    },
                    icon: const Icon(Icons.shopping_cart_outlined),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
