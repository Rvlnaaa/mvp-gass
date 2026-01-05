import 'package:flutter/material.dart';

class SettingScreen extends StatefulWidget {
  final String name;
  final String email;

  const SettingScreen({super.key, required this.name, required this.email});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  late TextEditingController nameController;
  late TextEditingController emailController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.name);
    emailController = TextEditingController(text: widget.email);
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pengaturan")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Nama", style: TextStyle(fontSize: 16)),
            TextField(controller: nameController),

            const SizedBox(height: 16),

            const Text("Email", style: TextStyle(fontSize: 16)),
            TextField(controller: emailController),

            const SizedBox(height: 24),

            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, {
                    "name": nameController.text,
                    "email": emailController.text,
                  });
                },
                child: const Text("Simpan Pengaturan"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
