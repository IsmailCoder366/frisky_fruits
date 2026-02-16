import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/routes/app_routes.dart';
import '../../home/bloc/favorite_bloc.dart';
import '../../home/bloc/favorite_event.dart';
import '../../home/bloc/favorite_state.dart';
import '../models/product_model.dart';

class ProductGridItem extends StatelessWidget {
  final ProductModel product;

  const ProductGridItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          Routes.productDetails,
          arguments: product,
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            // Background Image
            Positioned.fill(
              child: Image.asset(product.imagePath, fit: BoxFit.cover),
            ),
            // Dark Gradient Overlay
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
                  ),
                ),
              ),
            ),

            // --- FAVORITE LOGIC START ---
            Positioned(
              top: 10,
              left: 10,
              child: BlocBuilder<FavoritesBloc, FavoritesState>(
                builder: (context, state) {
                  // Logic: Check if this specific fruit name is in the BLoC's list
                  bool isFavorite = state.favoriteItems.any((item) => item['title'] == product.name);

                  return GestureDetector(
                    onTap: () {
                      // Logic: Convert model to Map and send to BLoC
                      final productMap = {
                        'title': product.name,
                        'price': product.price,
                        'imagePath': product.imagePath,
                      };
                      context.read<FavoritesBloc>().add(ToggleFavorite(productMap));
                    },
                    child: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite ? Colors.red : Colors.white,
                    ),
                  );
                },
              ),
            ),
            // --- FAVORITE LOGIC END ---

            // Product Info
            Positioned(
              bottom: 15,
              left: 15,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Text(
                    product.price,
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}