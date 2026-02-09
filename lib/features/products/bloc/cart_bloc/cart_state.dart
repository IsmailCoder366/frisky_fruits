import '../../models/product_model.dart';

class CartState {
  final List<ProductModel> items;
  CartState({this.items = const []});
}