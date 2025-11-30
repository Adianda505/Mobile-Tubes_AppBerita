import 'package:flutter/material.dart';

class introPage1 extends StatelessWidget {
  const introPage1({super.key});

  @override
  Widget build(BuildContext context) {
    // Mendapatkan tinggi layar saat ini
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 67, 18, 89),
              Color.fromARGB(255, 0, 0, 0)
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea( // Menggunakan SafeArea agar konten tidak terpotong
          child: Column(
            // Mengatur elemen agar berada di bagian atas dan tengah secara vertikal
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // 1. Gambar (Top Section)
              Padding(
                padding: EdgeInsets.only(top: screenHeight * 0.1), // Jarak 10% dari atas layar
                child: Image.asset(
                  "assets/images/info.png",
                  // Menggunakan proporsi layar untuk ukuran gambar
                  height: screenHeight * 0.45, // Gambar mengambil 45% tinggi layar
                ),
              ),

              // Spacer untuk memberikan jarak fleksibel antara Gambar dan Teks
              const Spacer(flex: 1), 

              // 2. Teks Judul (Middle Section)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  "Find your football update here",
                  textAlign: TextAlign.justify, // Menggunakan center agar mudah diatur
                  style: const TextStyle(
                    fontSize: 24, // Ditingkatkan agar lebih menonjol
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              
              // SizedBox untuk jarak tetap antara Judul dan Deskripsi
              const SizedBox(height: 15),

              // 3. Teks Deskripsi (Lower Middle Section)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 45.0),
                child: Text(
                  "Stay informed with fresh match news, player insights, and highlight moments. All in one place",
                  textAlign: TextAlign.left, // Menggunakan center
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),

              // Spacer untuk memberikan jarak fleksibel antara Teks dan Area Dot/Tombol
              // Jarak ini akan menjadi tempat dot indicator dan tombol "Skip/Next" di OnBoardingScreen
              const Spacer(flex: 2), // Memberikan lebih banyak ruang di bawah

              // CATATAN: Area dot slider dan tombol akan berada di sini (dibuat di widget OnBoardingScreen)
              // Kita tambahkan SizedBox kosong sebagai penanda posisi agar widget OnBoardingScreen bisa menempatkannya dengan alignment yang tepat

              const SizedBox(height: 100), // Menyediakan ruang untuk dot dan tombol

            ],
          ),
        ),
      ),
    );
  }
}