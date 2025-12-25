// import 'package:field_area_proj_mobile/screen/article/reading_list.dart';
// import 'package:field_area_proj_mobile/profile.dart';
// import 'package:field_area_proj_mobile/screen/home_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class Beranda extends StatelessWidget {
//  const Beranda({super.key});

//  @override
//  Widget build(BuildContext context) {
//   return MaterialApp(
//     debugShowCheckedModeBanner: false,
//     title: 'Field Area',
//     home: const BerandaPage(title: 'Beranda'),
//   );  
//  }
// }

// class _AppBarActionCircle extends StatelessWidget {
//   final IconData icon;
//   final Color color;
//   const _AppBarActionCircle({required this.icon, required this.color});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 45, 
//       height: 45, 
//       decoration: BoxDecoration(
//         color: color,
//         shape: BoxShape.circle,
//       ),
//       child: Icon(
//         icon,
//         color: Colors.white,
//         size: 28, 
//       ),
//     );
//   }
// }

// class BerandaPage extends StatefulWidget { 
//  const BerandaPage({super.key, required this.title});

//  final String title;

//  @override
//  State<BerandaPage> createState() => _BerandaPageState();
// }


// class _BerandaPageState extends State<BerandaPage>{
//  int _selectedIndex = 3;
//  Widget _buildNavItem(IconData icon, String label, VoidCallback onTap, int index){
//   bool isSelected = index == _selectedIndex;
//   Color color = isSelected ? const Color.fromARGB(255, 255, 255, 255) : const Color.fromARGB(255, 255, 255, 255);

//   return GestureDetector(
//    onTap: onTap,
//    child: Column(
//     mainAxisSize: MainAxisSize.min,
//     mainAxisAlignment: MainAxisAlignment.center,
//     children: <Widget>[
//      Icon(icon, color: color, size: 26),
//      const SizedBox(height: 4),
//      Text(
//       label,
//       style: TextStyle(
//        fontSize: 10,
//        color: color,
//        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
//       ),
//      ),
//     ],
//    ),
//   );
//  }

//  @override
//  Widget build(BuildContext context) {
//   final user = FirebaseAuth.instance.currentUser;
//   return Scaffold(
//    bottomNavigationBar: Container(
//     decoration: BoxDecoration(
//      color: Color.fromARGB(255, 33, 1, 47),
//     ),
//     child: Padding(
//      padding: const EdgeInsets.only(bottom: 10.0),
//      child: Row(
//       mainAxisSize: MainAxisSize.max,
//       mainAxisAlignment: MainAxisAlignment.spaceAround,
//       children: <Widget>[
//        Padding(
//         padding: const EdgeInsets.only(top: 5),
//         child: Row(
//          // mainAxisSize: MainAxisSize.max,
//          // mainAxisAlignment: MainAxisAlignment.spaceAround,
//          children: [
//           SizedBox(height: 5),
//        // Tombol Home (index 0)
//        _buildNavItem(Icons.home, "Home", () {
//         Navigator.pushReplacement(
//          context,
//          MaterialPageRoute(builder: (context) => const Beranda()),
//         );},0),
//        SizedBox(width: 100),

//        // reading list
//        _buildNavItem(Icons.bookmark, "Reading List", () {
//         Navigator.push(context, MaterialPageRoute(builder: (context) => const ReadingList())); },1),
//        SizedBox(width: 100),

//        //Profile
//        _buildNavItem(Icons.account_circle, "Profile", () {
//         Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfileScreen())); },2),
//        SizedBox(width: 5),
//        ]
//        )
//        )
//       ],
//      ),
//     ),
//    ),
 
//    //AppBar
//    appBar: AppBar(
//   toolbarHeight: 100.0,
//   backgroundColor: Colors.black,
  
//   // Widget 'title' akan berada di sebelah kiri
//   title: Row(
//     children: [
//       // 1. Avatar/Lingkaran Ungu Muda
//       const Padding(
//         padding: EdgeInsets.only(right: 8.0),
//       ),
//       // 2. Teks Sapaan
//       const Text(
//         'Field Area',
//         style: TextStyle(
//           fontSize: 24, // Ukuran font yang lebih besar
//           color: Colors.white,
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//     ],
//   ),
  
//   // Widget 'actions' akan berada di sebelah kanan
//   actions: [
//     // Fungsi pembungkus untuk membuat lingkaran ungu
//     _AppBarActionCircle(
//       icon: Icons.search_outlined,
//       color: const Color(0xFF512DA8), // Warna ungu tua
//     ),
//     // Padding di antara icon
    
//     // Padding di akhir (sebelah kanan)
//     const SizedBox(width: 16.0), 
//   ],
// ),
//   body: HomeScreen(),
//   );
//  }
// }