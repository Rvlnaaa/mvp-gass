import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:makanan/models/dummy_resep.dart';
import 'package:makanan/models/slider_resep.dart';
import 'package:makanan/screens/detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final PageController _pageController =
      PageController(viewportFraction: 0.9);

  late List<bool> _isLoved;

  @override
  void initState() {
    super.initState();

    _isLoved = List.generate(dummyResep.length, (_) => false);

    // Load data favorit dari SharedPreferences
    loadFavorites().then((favIds) {
      setState(() {
        for (int i = 0; i < dummyResep.length; i++) {
          if (favIds.contains(dummyResep[i].id)) {
            _isLoved[i] = true;
          }
        }
      });
    });
  }

  // SIMPAN favorit ke SharedPreferences
  Future<void> saveFavorites(List<int> ids) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(ids);
    await prefs.setString("favorites", jsonString);
  }

  //AMBIL favorit dari SharedPreferences
  Future<List<int>> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString("favorites");

    if (jsonString == null) return [];
    return List<int>.from(jsonDecode(jsonString));
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

  int crossAxisCount;
  if (screenWidth >= 900) {
    crossAxisCount = 5; // tablet / desktop
  } else if (screenWidth >= 600) {
    crossAxisCount = 4; // hp besar
  } else {
    crossAxisCount = 3; // hp normal
  }
    return Scaffold(
      appBar: AppBar(
        title: const Text("Resepku"),
        backgroundColor: Colors.brown,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // ================= SLIDER ATAS =================
          SizedBox(
            height: 240,
            child: PageView.builder(
              controller: _pageController,
              itemCount: sliderResep.length,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              itemBuilder: (context, index) {
                final recipe = sliderResep[index];

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
                    padding:
                        const EdgeInsets.symmetric(horizontal: 4.0),
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

          // ================= DOT INDICATOR =================
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: sliderResep.asMap().entries.map((entry) {
              return Container(
                width: 8,
                height: 8,
                margin: const EdgeInsets.symmetric(horizontal: 4),
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

          // ================= RESEP PILIHAN =================
          const Text(
            "Resep Pilihan",
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 16),

          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 12,
              mainAxisSpacing: 16,
              childAspectRatio: 3 / 5,
            ),
            itemCount: dummyResep.length,
            itemBuilder: (context, index) {
              return _portraitCard(context, index);
            },
          ),
        ],
      ),
    );
  }

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
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 6),

              //ICON LOVE – DISIMPAN PERMANEN
              GestureDetector(
                onTap: () async {
                  setState(() {
                    _isLoved[index] = !_isLoved[index];
                  });

                  List<int> favIds = [];
                  for (int i = 0; i < dummyResep.length; i++) {
                    if (_isLoved[i]) {
                      favIds.add(dummyResep[i].id);
                    }
                  }

                  await saveFavorites(favIds);
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
