import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/product_model.dart';
import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartState()) {

    on<AddToCart>((event, emit) {
      final List<ProductModel> currentItems = List.from(state.items);

      // Check if product already exists in cart
      int existingIndex = currentItems.indexWhere((item) => item.name == event.product.name);

      if (existingIndex != -1) {
        // Update quantity and price of existing item
        final existingItem = currentItems[existingIndex];
        currentItems[existingIndex] = existingItem.copyWith(
          quantity: existingItem.quantity + event.product.quantity,
          totalItemPrice: existingItem.totalItemPrice + event.product.totalItemPrice,
        );
      } else {
        // Add new item
        currentItems.add(event.product);
      }

      emit(CartState(items: currentItems));
    });

    on<RemoveFromCart>((event, emit) {
      // We use .name because your ProductModel doesn't have an .id field
      final updatedItems = List<ProductModel>.from(state.items)
        ..removeWhere((item) => item.name == event.product.name);

      emit(CartState(items: updatedItems));
    });

    // 👈 Added a ClearCart event (useful after successful payment)
    on<ClearCart>((event, emit) {
      emit(CartState(items: []));
    });
  }
}