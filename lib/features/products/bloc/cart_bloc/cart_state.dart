import '../../models/product_model.dart';

class CartState {
  final List<ProductModel> items;

  CartState({this.items = const []});

  /// 💰 Calculates the total price of all items currently in the cart.
  /// This is used by the Payment Screen to know how much to charge the customer.
  double get totalAmount {
    return items.fold(0.0, (total, current) => total + current.totalItemPrice);
  }

}