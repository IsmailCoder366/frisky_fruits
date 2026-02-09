import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/constants/app_colors.dart';
import '../bloc/cart_bloc/cart_bloc.dart';
import '../bloc/cart_bloc/cart_state.dart';
import '../bloc/cart_bloc/cart_event.dart';
import '../widgets/cart_item_tile.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
          Text('Place Order', style: TextStyle(color: AppColors.orangeText))
        ],
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state.items.isEmpty) {
            return const Center(
              child: Text(
                "Your cart is empty!",
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            );
          }

          return ListView.builder(
            itemCount: state.items.length,
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
            itemBuilder: (context, index) {
              final product = state.items[index];

              // --- PRICE LOGIC FIX ---
              // Extract the numeric value (e.g., "$7.2" -> 7.2)
              final double unitPrice = double.tryParse(
                  product.price.replaceAll('\$', '')
              ) ?? 0.0;

              // Multiply by quantity if your product model stores it,
              // otherwise, it uses the unit price.
              final String displayPrice = "\$${unitPrice.toStringAsFixed(1)}";

              return Dismissible(
                key: Key('${product.name}_$index'),
                direction: DismissDirection.endToStart,
                background: Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 25),
                  margin: const EdgeInsets.only(bottom: 15),
                  decoration: BoxDecoration(
                    color: Colors.redAccent.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Icon(Icons.delete_outline, color: Colors.white, size: 30),
                ),
                onDismissed: (direction) {
                  context.read<CartBloc>().add(RemoveFromCart(product));
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("${product.name} removed from cart"),
                      backgroundColor: Colors.black87,
                      duration: const Duration(seconds: 1),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: CartItemTile(
                    product: product,
                    category: "FRUITS",
                    // Ensure your CartItemTile accepts a 'price' parameter
                    // or uses the product.price correctly
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