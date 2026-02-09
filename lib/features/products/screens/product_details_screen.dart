import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../widgets/details_bottom_action.dart';
import '../widgets/details_image_header.dart';
import '../widgets/rating_row.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ModalRoute.of(context)!.settings.arguments as ProductModel;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            DetailsImageHeader(images: [product.imagePath]),
            Transform.translate(
              offset: const Offset(0, -35),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("FRUITS", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black54)),
                    Text(product.name, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 15),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(product.price, style: const TextStyle(fontSize: 26, color: Color(0xFFFFCC4D), fontWeight: FontWeight.bold)),
                        _buildQuantitySelector(),
                      ],
                    ),

                    const SizedBox(height: 20),
                    const RatingRow(),

                    const SizedBox(height: 30),
                    _buildTabs(),

                    const SizedBox(height: 20),
                    const Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                      style: TextStyle(color: Colors.black54, height: 1.6, fontSize: 15),
                    ),

                    const SizedBox(height: 30),
                    DetailsBottomActions(price: product.price),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Smaller helper widgets kept local if they are not reused elsewhere
  Widget _buildQuantitySelector() {
    return Container(
      decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(15)),
      child: Row(
        children: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.remove, color: Color(0xFFFFCC4D))),
          const Text("3", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.add, color: Color(0xFFFFCC4D))),
        ],
      ),
    );
  }

  Widget _buildTabs() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Description", style: TextStyle(fontWeight: FontWeight.bold, decoration: TextDecoration.underline, decorationColor: Color(0xFFFFCC4D))),
        Text("Review", style: TextStyle(color: Colors.grey)),
        Text("Discussion", style: TextStyle(color: Colors.grey)),
      ],
    );
  }
}