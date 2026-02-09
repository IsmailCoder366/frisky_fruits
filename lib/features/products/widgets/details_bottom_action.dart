import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/cart_bloc/cart_bloc.dart';
import '../bloc/cart_bloc/cart_event.dart';
import '../bloc/product_bloc/product_bloc.dart'; // Import this
import '../bloc/product_bloc/product_state.dart'; // Import this
import '../models/product_model.dart';

class DetailsBottomActions extends StatelessWidget {
  final String price;
  final ProductModel product;

  const DetailsBottomActions({
    super.key,
    required this.price,
    required this.product
  });

  @override
  Widget build(BuildContext context) {
    // We use BlocBuilder here to grab the current quantity and total price from ProductBloc
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, productState) {
        return Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                    color: const Color(0xFF1DBF73),
                    borderRadius: BorderRadius.circular(20)
                ),
                child: const Icon(Icons.favorite, color: Colors.white),
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFFCC4D),
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                ),
                onPressed: () {
                  // Now we use productState to get the live data
                  final productToCart = product.copyWith(
                    quantity: productState.quantity,
                    totalItemPrice: productState.totalPrice,
                    // We also update the price string to the total price
                    price: "\$${productState.totalPrice.toStringAsFixed(1)}",
                  );

                  // Add the updated product to the CartBloc
                  context.read<CartBloc>().add(AddToCart(productToCart));

                  Navigator.pushNamed(context, '/cart');
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                        "ADD TO CART",
                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)
                    ),
                    Text(
                        price, // This is the price passed from the Screen
                        style: const TextStyle(color: Colors.black87, fontSize: 12)
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}