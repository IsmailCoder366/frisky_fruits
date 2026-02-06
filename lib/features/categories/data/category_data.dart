import '../models/category_model.dart';

class CategoryData {
  static List<CategoryModel> categories = [
    CategoryModel(name: "Fruits", imagePath: 'assets/images/fruits.png', itemCount: 87),
    CategoryModel(name: "Vegetables", imagePath: 'assets/images/vegetables.png', itemCount: 87),
    CategoryModel(name: "Mushroom", imagePath: 'assets/images/mashrooms.png', itemCount: 87),
    CategoryModel(name: "Dairy", imagePath: 'assets/images/diary.png', itemCount: 87),
    CategoryModel(name: "Oats", imagePath: 'assets/images/oats.png', itemCount: 87),
    CategoryModel(name: "Bread", imagePath: 'assets/images/bread.png', itemCount: 87),
    CategoryModel(name: "Rice", imagePath: 'assets/images/rice.png', itemCount: 27),
    CategoryModel(name: "Egg", imagePath: 'assets/images/eggs.png', itemCount: 120),
  ];
}