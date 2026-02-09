import 'package:flutter/material.dart';
import '../models/product_model.dart';

class CartItemTile extends StatelessWidget {
  final ProductModel product;
  final String category;

  const CartItemTile({super.key, required this.product, required this.category});

  @override
  Widget build(BuildContext context) {
    return Container(
      // Added decoration for better UI consistency with the design
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.only(left: 15, right: 10, top: 15, bottom: 15),
      child: Row(
        children: [
          // 1. Image + Unit Price Badge
          SizedBox(
            width: 100,
            height: 110,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      image: AssetImage(product.imagePath),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 10,
                  right: 10,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFCC4D),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      // Showing the original unit price (e.g. $7.2)
                      product.price,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 20),

          // 2. Product Info Section
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    category.toUpperCase(),
                    style: const TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.bold)
                ),
                Text(
                    product.name,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // --- TOTAL PRICE FIX ---
                    // Now showing the total for this specific item (price * quantity)
                    Text(
                      "\$${product.totalItemPrice.toStringAsFixed(1)}",
                      style: const TextStyle(
                          color: Color(0xFFF2994A),
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    Spacer(),
                    // --- QUANTITY FIX ---
                    _buildQuantityCounter(product.quantity),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuantityCounter(int quantity) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(12)
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              // Future: Link to CartBloc to decrement
            },
            icon: const Icon(Icons.remove, size: 18, color: Colors.grey),
            constraints: const BoxConstraints(),
            padding: const EdgeInsets.all(8),
          ),
          Text(
              '$quantity', // Now shows the actual quantity from the model
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)
          ),
          IconButton(
            onPressed: () {
              // Future: Link to CartBloc to increment
            },
            icon: const Icon(Icons.add, size: 18, color: Colors.grey),
            constraints: const BoxConstraints(),
            padding: const EdgeInsets.all(8),
          ),
        ],
      ),
    );
  }
}