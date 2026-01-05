import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> login() async {
    String inputUser = usernameController.text.trim().toLowerCase();
    String inputPass = passwordController.text.trim();

    if (inputUser.isEmpty || inputPass.isEmpty) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            title: const Text(
              "Peringatan",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            content: const Text("Silakan isi username dan password."),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("OK"),
              ),
            ],
          );
        },
      );
      return;
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();

    String savedUser = (prefs.getString("username") ?? "").toLowerCase();
    String savedPass = prefs.getString("password") ?? "";

    if (savedUser.isEmpty) {
      _showDialog(
        "Akun belum terdaftar",
        "Silakan lakukan registrasi terlebih dahulu.",
      );
      return;
    }

    if (inputUser != savedUser) {
      _showDialog("Username Salah", "Username tidak ditemukan.");
      return;
    }

    if (inputPass != savedPass) {
      _showDialog("Kata Sandi Salah", "Password yang kamu masukkan salah.");
      return;
    }

    Navigator.pushReplacementNamed(context, '/main');
  }

  void _showDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false, // 🔥 Tidak bisa swipe-back
      child: Scaffold(
        body: Stack(
          children: [
            Positioned.fill(
              child: Image.asset("images/makanan4.jpg", fit: BoxFit.cover),
            ),

            Positioned.fill(
              child: Container(color: Colors.black.withOpacity(0.4)),
            ),

            Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "LOGIN",
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 40),

                    TextField(
                      controller: usernameController,
                      style: const TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        labelText: "Masukkan Username",
                        labelStyle: const TextStyle(color: Colors.black54),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.85),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    TextField(
                      controller: passwordController,
                      obscureText: true,
                      style: const TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        labelText: "Masukkan Password",
                        labelStyle: const TextStyle(color: Colors.black54),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.85),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.brown,
                        padding: const EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: 60,
                        ),
                      ),
                      onPressed: login,
                      child: const Text(
                        "LOGIN",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),

                    const SizedBox(height: 15),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Belum punya akun? ",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, "/register");
                          },
                          child: const Text(
                            "Daftar",
                            style: TextStyle(
                              color: Colors.blueAccent,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ); // ← ini tadi yang kurang!
  }
}
