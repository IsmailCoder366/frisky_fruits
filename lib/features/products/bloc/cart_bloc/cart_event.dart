import '../../models/product_model.dart';

abstract class CartEvent {}

class AddToCart extends CartEvent {
  final ProductModel product;
  AddToCart(this.product);
}

class RemoveFromCart extends CartEvent {
  final ProductModel product;
  RemoveFromCart(this.product);
}

/// 🧹 Call this event after a successful checkout
/// to reset the cart for the user.
class ClearCart extends CartEvent {}