import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // =====================
          // Background fullscreen
          // =====================
          Positioned.fill(
            child: Image.asset(
              "images/makanan3.jpg", // ganti sesuai path
              fit: BoxFit.cover,
            ),
          ),

          Positioned.fill(
            child: Container(color: Colors.black.withOpacity(0.2)),
          ),

          // =====================
          // Form register di tengah layar
          // =====================
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Register",
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Nama Lengkap
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Nama Lengkap",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.8),
                      border: OutlineInputBorder(),
                      hintText: "Masukkan nama lengkap",
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Email
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Email", style: TextStyle(color: Colors.white)),
                  ),
                  TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.8),
                      border: OutlineInputBorder(),
                      hintText: "Masukkan email",
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Password
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Password",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.8),
                      border: OutlineInputBorder(),
                      hintText: "Masukkan password",
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
                    onPressed: () {
                      Navigator.pushNamed(context, '/login');
                    },
                    child: const Text(
                      "REGISTER",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
