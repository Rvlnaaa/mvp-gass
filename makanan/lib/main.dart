import 'package:flutter/material.dart';
import 'package:makanan/screens/login_screen.dart';
import 'package:makanan/screens/profil_screen.dart';
import 'package:makanan/screens/home_screen.dart';
import 'package:makanan/screens/search_screen.dart';
import 'package:makanan/screens/resepku_screen.dart';
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

  // Fungsi untuk toggle theme dari SettingsScreen
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
        '/profil': (context) => ProfilScreen(toggleTheme: toggleTheme),
        '/favorite': (context) => FavoriteScreen(),
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

  @override
  Widget build(BuildContext context) {
    // List halaman untuk bottom navigation
    final pages = [
      HomeScreen(),
      SearchScreen(),
      FavoriteScreen(),
      ResepkuScreen(),
      ProfilScreen(toggleTheme: widget.toggleTheme ?? (_) {}),
    ];

    return Scaffold(
      body: pages[index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (i) {
          setState(() => index = i);
        },
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Cari"),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Favorit"),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: "Resepku"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profil"),
        ],
      ),
    );
  }
}
