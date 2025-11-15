import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              "images/makanan2.jpg",
              fit: BoxFit.cover,
            ),
          ),

          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.5),
              ),
            ),
          

          // Konten Utama
          Center(
            child: SingleChildScrollView(
            child: Padding(
            padding: const EdgeInsets.only(top: 80, bottom: 10), // ⭐ jarak dari atas
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  
                   // TEXT RESEPKU
                  Text(
                    "Resepku",
                    style: TextStyle(
                      fontSize: width < 600 ? 36 : 46,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 252, 249, 249),
                    ),
                  ),

                  SizedBox(height: 10),


                  // GAMBAR UTAMA
                  Image.asset(
                    "images/makanan.jpg",
                    width: width * 0.7,

                  ),

                  SizedBox(height: 5),

                  // WELCOME TITLE
                  Text(
                    "WELCOME",
                    style: TextStyle(
                      fontSize: width < 600 ? 26 : 36,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 248, 248, 248),
                    ),
                  ),

                  SizedBox(height: 10),

                  // BUTTON LOGIN
                  SizedBox(
                    width: width * 0.4,
                    height: 45,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/login');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text(
                        "LOGIN",
                        style: TextStyle(color: Color.fromARGB(255, 249, 249, 249)),
                      ),
                    ),
                  ),

                  SizedBox(height: 15),

                  // BUTTON REGISTER
                  SizedBox(
                    width: width * 0.4,
                    height: 45,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/register');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text(
                        "REGISTER",
                        style: TextStyle(color: Color.fromARGB(255, 254, 254, 254)),
                      ),
                    ),
                  ),

                  SizedBox(height: 30),
                 ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
