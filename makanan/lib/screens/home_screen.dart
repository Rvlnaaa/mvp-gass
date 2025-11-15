import 'package:flutter/material.dart';
import 'package:makanan/models/dummy_resep.dart';
import 'package:makanan/screens/detail_screen.dart';
import 'package:makanan/screens/search_screen.dart'; // 🔍 TAMBAHKAN IMPORT INI

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final PageController _pageController = PageController(viewportFraction: 0.9);

  // state untuk love icon
  late List<bool> _isLoved;

  @override
  void initState() {
    super.initState();
    // semua resep awalnya tidak loved
    _isLoved = List.generate(dummyResep.length, (_) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // =========================
      // APPBAR + TOMBOL SEARCH
      // =========================
      appBar: AppBar(
        title: const Text("Resepku"),
        backgroundColor: Colors.brown,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SearchScreen()),
              );
            },
          )
        ],
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // =====================
          // Carousel landscape
          // =====================
          SizedBox(
            height: 240,
            child: PageView.builder(
              controller: _pageController,
              itemCount: dummyResep.length,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              itemBuilder: (context, index) {
                final recipe = dummyResep[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DetailScreen(recipe: recipe),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        recipe.imageUrl,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 8),

          // dot indicator
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: dummyResep.asMap().entries.map((entry) {
              return Container(
                width: 8.0,
                height: 8.0,
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentIndex == entry.key
                      ? Colors.brown
                      : Colors.brown.withOpacity(0.3),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 24),

          // =====================
          // Judul
          // =====================
          const Text(
            "Resep Pilihan",
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          // =====================
          // 3 gambar portrait sejajar
          // =====================
          Row(
            children: [
              Expanded(child: _portraitCard(context, 0)),
              const SizedBox(width: 12),
              Expanded(child: _portraitCard(context, 1)),
              const SizedBox(width: 12),
              Expanded(child: _portraitCard(context, 2)),
            ],
          ),
        ],
      ),
    );
  }

  // Widget portrait card
  Widget _portraitCard(BuildContext context, int index) {
    final recipe = dummyResep[index];
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => DetailScreen(recipe: recipe),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AspectRatio(
            aspectRatio: 3 / 4,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                recipe.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  recipe.title,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(width: 6),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _isLoved[index] = !_isLoved[index];
                  });
                },
                child: Icon(
                  _isLoved[index]
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color: Colors.red,
                  size: 20,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
