class ProductModel {
  final String name;
  final String price;
  final String imagePath;
  final bool isFavorite;

  const ProductModel({
    required this.name,
    required this.price,
    required this.imagePath,
    this.isFavorite = false,
  });
}