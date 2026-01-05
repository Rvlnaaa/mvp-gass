import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'settings_screen.dart';
import 'favorite_screen.dart'; // 🔥 tambahkan import ini

class ProfilScreen extends StatefulWidget {
  const ProfilScreen({super.key});

  @override
  State<ProfilScreen> createState() => _ProfilScreenState();
}

class _ProfilScreenState extends State<ProfilScreen> {
  String profileName = "Dian Hasanah";
  String profileEmail = "dianhasanah@gmail.com";

  String? profileImageBase64; // 🔥 tempat foto yang disimpan local

  @override
  void initState() {
    super.initState();
    loadProfileData();
  }

  // 🔥 ambil semua data (nama, email, foto)
  Future<void> loadProfileData() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      profileName = prefs.getString("name") ?? profileName;
      profileEmail = prefs.getString("email") ?? profileEmail;
      profileImageBase64 = prefs.getString("profile_image");
    });
  }

  // 🔥 simpan nama, email
  Future<void> saveProfile(String name, String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("name", name);
    await prefs.setString("email", email);
  }

  // 🔥 pilih foto & simpan ke SharedPreferences
  Future<void> pickImage() async {
    final picker = ImagePicker();
    final XFile? img = await picker.pickImage(source: ImageSource.gallery);

    if (img == null) return;

    final bytes = await img.readAsBytes();
    final base64String = base64Encode(bytes);

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("profile_image", base64String);

    setState(() {
      profileImageBase64 = base64String;
    });
  }

  @override
  Widget build(BuildContext context) {
    ImageProvider avatarImage;

    // 🔥 jika ada foto dari SharedPreferences
    if (profileImageBase64 != null) {
      avatarImage = MemoryImage(base64Decode(profileImageBase64!));
    } else {
      // 🔥 default foto lama kamu
      avatarImage = NetworkImage(
        "https://tse3.mm.bing.net/th/id/OIP.ejaCX30eXrYZiIMOwXtQ3QHaHa?pid=Api&P=0&h=220",
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Profil")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // FOTO PROFIL
            Center(
              child: Stack(
                children: [
                  CircleAvatar(radius: 60, backgroundImage: avatarImage),

                  // 🔥 tombol edit foto di pojok
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: pickImage,
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: const BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            Text(
              profileName,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            Text(
              profileEmail,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),

            const SizedBox(height: 30),

            // LIST MENU
            Card(
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.settings),
                    title: const Text("Pengaturan"),
                    onTap: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => SettingScreen(
                            name: profileName,
                            email: profileEmail,
                          ),
                        ),
                      );

                      if (result != null && result is Map<String, String>) {
                        setState(() {
                          profileName = result["name"]!;
                          profileEmail = result["email"]!;
                        });

                        saveProfile(profileName, profileEmail);
                      }
                    },
                  ),

                  const Divider(height: 1),

                  // ❤️ FAVORIT - SUDAH DIUBAH
                  ListTile(
                    leading: const Icon(Icons.favorite),
                    title: const Text("Favorit"),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              const FavoriteScreen(), // 🔥 pindah halaman
                        ),
                      );
                    },
                  ),

                  const Divider(height: 1),

                  ListTile(
                    leading: const Icon(Icons.exit_to_app),
                    title: const Text("Logout"),
                    onTap: () {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        '/login',
                        (route) => false,
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
  }
}
