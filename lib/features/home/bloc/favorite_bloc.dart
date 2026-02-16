import 'package:flutter_bloc/flutter_bloc.dart';
import 'favorite_event.dart';
import 'favorite_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  // We initialize with an empty list in the FavoritesState
  FavoritesBloc() : super(FavoritesState([])) {

    on<ToggleFavorite>((event, emit) {
      // 1. Create a fresh copy of the current list to avoid mutating the state directly
      final List<Map<String, String>> currentList = List.from(state.favoriteItems);

      // 2. Logic: Check if the item is already in the favorites by comparing titles
      // In your project, using 'title' works as a unique ID for now
      final bool exists = currentList.any((item) => item['title'] == event.product['title']);

      if (exists) {
        // 3. Logic: If it exists, remove it (Un-favorite)
        currentList.removeWhere((item) => item['title'] == event.product['title']);
      } else {
        // 4. Logic: If it's new, add it to the list
        currentList.add(event.product);
      }

      // 5. Emit the new state with the updated list to trigger UI rebuild
      emit(FavoritesState(currentList));
    });
  }
}