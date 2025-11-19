import 'package:flutter/material.dart';
import 'package:makanan/models/dummy_resep.dart';
import 'package:makanan/screens/detail_screen.dart';

class FavoriteScreen extends StatelessWidget {
  final List<int> favorites;

  const FavoriteScreen({super.key, required this.favorites});

  @override
  Widget build(BuildContext context) {
    if (favorites.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text("Favorit")),
        body: const Center(child: Text("Belum ada resep favorit")),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Favorit")),
      body: ListView.builder(
        itemCount: favorites.length,
        itemBuilder: (context, i) {
          final recipe = dummyResep[favorites[i]];
          return ListTile(
            leading: Image.asset(recipe.imageUrl),
            title: Text(recipe.title),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => DetailScreen(recipe: recipe)),
              );
            },
          );
        },
      ),
    );
  }
}
