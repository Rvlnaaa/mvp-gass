class Favorite {
  static List<int> favoriteIndexes = [];

  static void toggleFavorite(int index) {
    if (favoriteIndexes.contains(index)) {
      favoriteIndexes.remove(index);
    } else {
      favoriteIndexes.add(index);
    }
  }

  static bool isFavorite(int index) {
    return favoriteIndexes.contains(index);
  }

  static List<int> getFavorites() {
    return favoriteIndexes;
  }
}
