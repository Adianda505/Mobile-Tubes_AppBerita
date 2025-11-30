import 'package:field_area_proj_mobile/intro_app/intro1.dart';
import 'package:field_area_proj_mobile/intro_app/intro2.dart';
import 'package:field_area_proj_mobile/intro_app/intro3.dart';
import 'package:field_area_proj_mobile/login/regist/regist.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  
  final PageController _controller = PageController();
  
  // Logika halaman terakhir (index 2: introPage3)
  bool isLastIntroPage = false; 
  
  // Menyimpan indeks halaman saat ini
  int currentPage = 0; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 1. PAGEVIEW
          PageView(
            controller: _controller,
            physics: const BouncingScrollPhysics(),
            onPageChanged: (index) {
              setState(() {
                currentPage = index; // Menyimpan indeks saat ini
                // Halaman intro terakhir adalah index 2 (introPage3)
                isLastIntroPage = (index == 2); 
              });
            },
            children: const [
              introPage1(),
              introPage2(),
              introPage3(),
              Regist(), // Index 3: Halaman yang ingin tampil independen
            ],
          ),

          // 2. SMOOTH PAGE INDICATOR (HANYA TAMPIL DI HALAMAN 0, 1, 2)
          // Indikator ini tidak akan muncul saat currentPage == 3 (Regist())
          if (currentPage <= 2) 
            Positioned(
              bottom: 180.0,
              // Mengatur posisi agar benar-benar di tengah (menghapus left: -270)
              left: 0, 
              right: 0,
              child: Center(
                child: SmoothPageIndicator(
                  controller: _controller,
                  // Count harus 3, karena hanya menghitung 3 halaman intro
                  count: 3, 
                  effect: const SlideEffect(
                    dotHeight: 8,
                    dotWidth: 8,
                    dotColor: Color.fromARGB(255, 143, 38, 191),
                    activeDotColor: Color.fromARGB(255, 203, 22, 170),
                  ),
                ),
              ),
            ),

          // 3. TOMBOL NAVIGASI (HANYA TAMPIL DI HALAMAN 0, 1, 2)
          if (currentPage <= 2) // Tampilkan tombol hanya jika bukan halaman Regist
            Positioned(
              bottom: 20.0, 
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Tombol SKIP (Hanya Skip ke halaman terakhir intro, index 2)
                    GestureDetector(
                      onTap: () {
                        // Lompat ke index 2 (introPage3)
                        _controller.jumpToPage(2); 
                      },
                      child: const Text(
                        'Skip',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 143, 38, 191)),
                      ),
                    ),

                    // FloatingActionButton (NEXT/CHECK)
                    FloatingActionButton(
                      onPressed: () {
                        if (isLastIntroPage) {
                          // Jika di halaman intro terakhir (index 2), pindah ke Regist (index 3)
                          _controller.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeIn,
                          );
                        } else {
                          // Pindah ke halaman berikutnya (index 0 ke 1, atau 1 ke 2)
                          _controller.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeIn,
                          );
                        }
                      },
                      backgroundColor: const Color.fromARGB(255, 203, 22, 170), 
                      child: Icon(
                        // Tampilkan panah jika belum di halaman intro terakhir, check jika sudah
                        isLastIntroPage ? Icons.check : Icons.arrow_forward, 
                        color: Colors.white,
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