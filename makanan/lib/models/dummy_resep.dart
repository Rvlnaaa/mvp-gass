import 'resep.dart';

final List<Recipe> dummyResep = [
  Recipe(
    title: "Nasi Goreng Spesial",
    description: "Nasi goreng dengan telur, ayam, dan sayuran.",
    imageUrl: "images/nasgor2.jpg",
    ingredients: [
      "2 piring nasi",
      "1 butir telur",
      "Bawang merah",
      "Bawang putih",
      "Ayam suwir",
      "Kecap manis"
    ],
    steps: [
      "Tumis bawang sampai harum.",
      "Masukkan ayam dan telur.",
      "Masukkan nasi dan aduk rata.",
      "Tambahkan kecap dan bumbu.",
      "Sajikan hangat."
    ],
  ),

  Recipe(
    title: "Mie Goreng",
    description: "Mie goreng lezat dengan sayuran.",
    imageUrl: "images/migor.jpg",
    ingredients: [
      "1 bungkus mie",
      "Sayuran",
      "Bawang putih",
      "Kecap asin",
    ],
    steps: [
      "Rebus mie.",
      "Tumis bawang.",
      "Masukkan sayuran.",
      "Masukkan mie dan bumbu.",
    ],
  ),

  Recipe(
    title: "Ayam Geprek",
    description: "Ayam crispy dengan sambal pedas.",
    imageUrl: "images/ayprek.jpg",
    ingredients: [
      "Ayam goreng crispy",
      "Cabe rawit",
      "Bawang putih",
      "Garam",
    ],
    steps: [
      "Ulek sambal.",
      "Geprek ayam dengan sambal.",
      "Sajikan."
    ],
  ),
];
