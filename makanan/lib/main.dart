import 'package:flutter/material.dart';
import 'package:makanan/screens/login_screen.dart';
import 'package:makanan/screens/profil_screen.dart';
import 'package:makanan/screens/home_screen.dart';
import 'package:makanan/screens/search_screen.dart';
import 'package:makanan/screens/favorite_screen.dart';
import 'package:makanan/screens/settings_screen.dart'; // halaman setting simple

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDarkMode = false;

  void toggleTheme(bool value) {
    setState(() {
      isDarkMode = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi Makanan',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.brown,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.brown,
        brightness: Brightness.dark,
      ),
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginScreen(),
        '/main': (context) => MainNavigation(toggleTheme: toggleTheme),

        // ini route standar, tapi tidak dipakai saat dari bottom navigation
        '/profil': (context) =>
            ProfilScreen(toggleTheme: toggleTheme, favorites: []),

        '/favorite': (context) => FavoriteScreen(favorites: []),
        '/settings': (context) => SettingScreen(toggleTheme: toggleTheme),
      },
    );
  }
}

class MainNavigation extends StatefulWidget {
  final Function(bool)? toggleTheme;

  MainNavigation({this.toggleTheme});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int index = 0;

  // ✔ FAVORIT TERSIMPAN DI SINI (INI YANG PENTING!)
  List<int> favoriteIndexes = [];

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomeScreen(favorites: favoriteIndexes), // ✔ kirim ke home
      SearchScreen(),
      ProfilScreen(
        toggleTheme: widget.toggleTheme ?? (_) {},
        favorites: favoriteIndexes, // ✔ kirim ke profil
      ),
    ];

    return Scaffold(
      body: pages[index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (i) => setState(() => index = i),
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Cari"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profil"),
        ],
      ),
    );
  }
}
