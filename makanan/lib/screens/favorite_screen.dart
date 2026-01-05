import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:makanan/models/dummy_resep.dart';
import 'package:makanan/screens/detail_screen.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  List<int> favoriteIds = [];

  @override
  void initState() {
    super.initState();
    loadFavoriteData();
  }

  Future<void> loadFavoriteData() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString("favorites");

    if (jsonString != null) {
      setState(() {
        favoriteIds = List<int>.from(jsonDecode(jsonString));
      });
    }
  }

  Future<void> _toggleFavorite(int recipeId) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString("favorites");

    List<int> favIds = jsonString == null
        ? []
        : List<int>.from(jsonDecode(jsonString));

    if (favIds.contains(recipeId)) {
      favIds.remove(recipeId);
    } else {
      favIds.add(recipeId);
    }

    await prefs.setString("favorites", jsonEncode(favIds));

    setState(() {
      favoriteIds = favIds;
    });
  }

  @override
  Widget build(BuildContext context) {
    final favoriteRecipes = dummyResep
        .where((recipe) => favoriteIds.contains(recipe.id))
        .toList();

    return Scaffold(
      appBar: AppBar(title: const Text("Favorit")),
      body: favoriteRecipes.isEmpty
          ? const Center(child: Text("Belum ada favorit"))
          : Padding(
              padding: const EdgeInsets.all(12),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  childAspectRatio: 0.9,
                ),
                itemCount: favoriteRecipes.length,
                itemBuilder: (context, index) {
                  final recipe = favoriteRecipes[index];

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => DetailScreen(recipe: recipe),
                        ),
                      );
                    },
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // 🖼️ GAMBAR
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Image.asset(
                                    recipe.imageUrl,
                                    height: 120,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),

                              // 📌 JUDUL
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 6,
                                ),
                                child: Text(
                                  recipe.title,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // ❤️ LOVE POJOK KANAN BAWAH
                        Positioned(
                          bottom: 12,
                          right: 12,
                          child: GestureDetector(
                            onTap: () => _toggleFavorite(recipe.id),
                            child: Icon(
                              favoriteIds.contains(recipe.id)
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: Colors.red,
                              size: 22,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
    );
  }
}
