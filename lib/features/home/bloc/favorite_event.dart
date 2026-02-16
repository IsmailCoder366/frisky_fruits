abstract class FavoritesEvent {}

class ToggleFavorite extends FavoritesEvent {
  // We pass the product as a Map so the Bloc knows which item to add or remove
  final Map<String, String> product;

  ToggleFavorite(this.product);
}
class TabChanged extends FavoritesEvent {
  final int index;
  TabChanged(this.index);
}