import 'package:flutter/material.dart';
import 'package:makanan/models/favorite.dart';
import 'package:makanan/screens/favorite_screen.dart';
import 'settings_screen.dart';

class ProfilScreen extends StatefulWidget {
  final Function(bool) toggleTheme;
  final List<int> favorites; // ✔ sudah benar

  ProfilScreen({required this.toggleTheme, required this.favorites});

  @override
  _ProfilScreenState createState() => _ProfilScreenState();
}

class _ProfilScreenState extends State<ProfilScreen> {
  String profileName = "Dian Hasanah";
  String profileEmail = "dianhasanah@gmail.com";
  String profileImage =
      "https://tse3.mm.bing.net/th/id/OIP.ejaCX30eXrYZiIMOwXtQ3QHaHa?pid=Api&P=0&h=220";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profil")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Center(
              child: CircleAvatar(
                radius: 55,
                backgroundImage: NetworkImage(profileImage),
              ),
            ),
            SizedBox(height: 16),
            Text(
              profileName,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              profileEmail,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            SizedBox(height: 30),
            Card(
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.settings),
                    title: Text("Pengaturan"),
                    onTap: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SettingScreen(
                            toggleTheme: widget.toggleTheme,
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
                      }
                    },
                  ),
                  Divider(height: 1),

                  // ✔ BAGIAN FAVORIT — SUDAH BENAR
                  ListTile(
                    leading: Icon(Icons.favorite),
                    title: Text("Favorit"),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => FavoriteScreen(
                            favorites: Favorite.getFavorites(),
                          ),
                        ),
                      );
                    },
                  ),

                  Divider(height: 1),
                  ListTile(
                    leading: Icon(Icons.exit_to_app),
                    title: Text("Logout"),
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
