import 'package:flutter/material.dart';

class ResepkuScreen extends StatelessWidget {
  const ResepkuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Resepku")),
      body: const Center(child: Text("Koleksi resep buatanmu...")),
    );
  }
}
