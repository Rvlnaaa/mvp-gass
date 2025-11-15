import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  final List<Map<String, String>> resepList;

  const SearchScreen({super.key, required this.resepList});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String query = "";
  List<Map<String, String>> hasilPencarian = [];

  @override
  void initState() {
    super.initState();
    hasilPencarian = widget.resepList; // awal: tampilkan semua
  }

  void updateSearch(String text) {
    setState(() {
      query = text;
      hasilPencarian = widget.resepList.where((resep) {
        final nama = resep['nama']!.toLowerCase();
        final kategori = resep['kategori']!.toLowerCase();
        return nama.contains(query.toLowerCase()) ||
            kategori.contains(query.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cari Resep Masakan"),
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          // TextField untuk pencarian
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              onChanged: updateSearch,
              decoration: InputDecoration(
                hintText: 'Cari nama resep atau kategori...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
          ),

          // Hasil pencarian
          Expanded(
            child: hasilPencarian.isEmpty
                ? const Center(
                    child: Text("Tidak ada hasil."),
                  )
                : ListView.builder(
                    itemCount: hasilPencarian.length,
                    itemBuilder: (context, index) {
                      final resep = hasilPencarian[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        child: ListTile(
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              resep['gambar']!,
                              height: 60,
                              width: 60,
                              fit: BoxFit.cover,
                            ),
                          ),
                          title: Text(resep['nama']!),
                          subtitle: Text(resep['kategori']!),
                          onTap: () {
                            // arahkan ke detail resep
                          },
                        ),
                      );
                    },
                  ),
          )
        ],
      ),
    );
  }
}
