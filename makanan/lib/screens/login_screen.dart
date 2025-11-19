import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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
              "images/makanan4.jpg", // ganti sesuai path
              fit: BoxFit.cover,
            ),
          ),

          // =====================
          // Form login di tengah layar
          // =====================
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

                  // Nama
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Nama",
                      style: TextStyle(
                        fontSize: 18,
                        color: Color.fromARGB(255, 255, 254, 254),
                      ),
                    ),
                  ),
                  TextField(
                    controller: nameController,
                    style: const TextStyle(fontSize: 18), // font input
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.8),
                      border: OutlineInputBorder(),
                      hintText: "Masukkan nama",
                      hintStyle: const TextStyle(fontSize: 16), // hint
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Password
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Password",
                      style: TextStyle(
                        fontSize: 18,
                        color: Color.fromARGB(221, 255, 255, 255),
                      ),
                    ),
                  ),
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    style: const TextStyle(fontSize: 18),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.8),
                      border: OutlineInputBorder(),
                      hintText: "Masukkan password",
                      hintStyle: const TextStyle(fontSize: 16),
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
                      String name = nameController.text.trim();
                      String pass = passwordController.text.trim();

                      if (name.isEmpty || pass.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Nama dan password harus diisi"),
                          ),
                        );
                        return;
                      }

                      Navigator.pushReplacementNamed(context, '/main');
                    },
                    child: const Text(
                      "LOGIN",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 15),

                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/register');
                    },
                    child: const Text(
                      "Belum punya akun? Register",
                      style: TextStyle(fontSize: 16, color: Colors.white),
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
