import 'package:flutter/material.dart';

class SettingScreen extends StatefulWidget {
  final Function(bool) toggleTheme;
  final String name;
  final String email;

  SettingScreen({required this.toggleTheme, this.name = "", this.email = ""});

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  bool isDarkMode = false;

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
      appBar: AppBar(title: Text("Pengaturan")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Text("Nama", style: TextStyle(fontSize: 16)),
            TextField(controller: nameController),
            SizedBox(height: 10),
            Text("Email", style: TextStyle(fontSize: 16)),
            TextField(controller: emailController),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Mode Gelap"),
                Switch(
                  value: isDarkMode,
                  onChanged: (val) {
                    setState(() {
                      isDarkMode = val;
                    });
                    widget.toggleTheme(val);
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, {
                  "name": nameController.text,
                  "email": emailController.text,
                });
              },
              child: Text("Simpan Pengaturan"),
            ),
          ],
        ),
      ),
    );
  }
}
