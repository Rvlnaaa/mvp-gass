class Recipe {
  final int id; // 🔥 Tambahkan ID
  final String title;
  final String description;
  final String imageUrl;
  final List<String> ingredients;
  final List<String> steps;

  Recipe({
    required this.id, // 🔥 Tambahkan ke constructor
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.ingredients,
    required this.steps,
  });
}
