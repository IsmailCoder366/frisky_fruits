import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/product_model.dart';
import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartState()) {
    on<AddToCart>((event, emit) {
      // Create a new list with the existing items plus the new one
      final updatedItems = List<ProductModel>.from(state.items)..add(event.product);
      emit(CartState(items: updatedItems));
    });

    on<RemoveFromCart>((event, emit) {
      final updatedItems = List<ProductModel>.from(state.items)..remove(event.product);
      emit(CartState(items: updatedItems));
    });
  }
}