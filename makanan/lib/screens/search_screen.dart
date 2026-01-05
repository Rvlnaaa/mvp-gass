import 'package:flutter/material.dart';
import 'package:makanan/models/dummy_resep.dart';
import 'package:makanan/models/resep.dart';
import 'package:makanan/screens/detail_screen.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<int> _favIds = [];
  List<Recipe> _filteredResep = dummyResep;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadFavIds();
  }

  Future<void> _loadFavIds() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString("favorites");
    setState(() {
      _favIds = jsonString == null
          ? []
          : List<int>.from(jsonDecode(jsonString));
    });
  }

  void _filterResep(String query) {
    setState(() {
      _filteredResep = query.isEmpty
          ? dummyResep
          : dummyResep
                .where(
                  (r) => r.title.toLowerCase().contains(query.toLowerCase()),
                )
                .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pencarian Resep"),
        backgroundColor: Colors.orange,
      ),
      body: Column(
        children: [
          // SEARCH BAR
          Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.orange[50],
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                controller: _searchController,
                onChanged: _filterResep,
                decoration: const InputDecoration(
                  hintText: "Cari resep...",
                  prefixIcon: Icon(Icons.search),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),

          // LIST
          Expanded(
            child: ListView.builder(
              itemCount: _filteredResep.length,
              itemBuilder: (context, index) {
                final resep = _filteredResep[index];

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DetailScreen(recipe: resep),
                      ),
                    );
                  },
                  child: Card(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    color: Colors.grey[200],
                    elevation: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // =========================
                        // GAMBAR (TIDAK FULL LAYAR)
                        // =========================
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.asset(
                              resep.imageUrl,
                              height: 160,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),

                        // JUDUL + FAVORIT
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                resep.title.toUpperCase(),
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              IconButton(
                                icon: Icon(
                                  _favIds.contains(resep.id)
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: Colors.red,
                                ),
                                onPressed: () async {
                                  final prefs =
                                      await SharedPreferences.getInstance();

                                  setState(() {
                                    _favIds.contains(resep.id)
                                        ? _favIds.remove(resep.id)
                                        : _favIds.add(resep.id);
                                  });

                                  await prefs.setString(
                                    "favorites",
                                    jsonEncode(_favIds),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
