import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/routes/app_routes.dart';
import '../bloc/cart_bloc/cart_bloc.dart';
import '../bloc/cart_bloc/cart_event.dart';
import '../bloc/cart_bloc/cart_state.dart';
import '../widgets/cart_item_tile.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const double horizontalPadding = 25.0;

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Cart",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          // Aligning the text by wrapping it in Padding to match the body
          Padding(
            padding: const EdgeInsets.only(right: horizontalPadding),
            child: Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, Routes.checkout);
                },
                child: Text(
                    'Place Order',
                    style: TextStyle(
                      color: AppColors.orangeText,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    )
                ),
              ),
            ),
          )
        ],
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state.items.isEmpty) {
            return const Center(
              child: Text("Your cart is empty!"),
            );
          }

          return ListView.builder(
            itemCount: state.items.length,
            // Right horizontal padding matches the AppBar's action padding
            padding: const EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: 20
            ),
            itemBuilder: (context, index) {
              final product = state.items[index];

              return Dismissible(
                key: Key('${product.name}_$index'),
                direction: DismissDirection.endToStart,
                background: Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 20),
                  margin: const EdgeInsets.only(bottom: 15),
                  decoration: BoxDecoration(
                    color: Colors.redAccent.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Icon(Icons.delete_outline, color: Colors.white, size: 30),
                ),
                onDismissed: (direction) {
                  context.read<CartBloc>().add(RemoveFromCart(product));
                },
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: CartItemTile(
                    product: product,
                    category: "FRUITS",
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}