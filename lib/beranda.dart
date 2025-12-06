import 'package:field_area_proj_mobile/article/detail_article.dart';
import 'package:field_area_proj_mobile/article/reading_list.dart';
import 'package:field_area_proj_mobile/profile.dart';
import 'package:flutter/material.dart';

class Beranda extends StatelessWidget {
  const Beranda({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Field Area',
        home: const BerandaPage(title: 'Beranda'),
        
    );    
  }
}

class BerandaPage extends StatefulWidget { 
  const BerandaPage({super.key, required this.title});

  final String title;

  @override
  State<BerandaPage> createState() => _BerandaPageState();
}

class _BerandaPageState extends State<BerandaPage>{
   int _selectedIndex = 3;

  Widget _buildNavItem(IconData icon, String label,  VoidCallback onTap, int index){
    bool isSelected = index == _selectedIndex;
    Color color = isSelected ? const Color.fromARGB(255, 255, 255, 255) : const Color.fromARGB(255, 255, 255, 255);

    return GestureDetector(
          onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(icon, color: color, size: 26),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: color,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }



  Widget build(BuildContext context) {
    return Scaffold(

       bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 33, 1, 47),
        ),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
             children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Row(
                  // mainAxisSize: MainAxisSize.max,
                  // mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(height: 5),
              // Tombol Home (index 0)
              _buildNavItem(Icons.home, "Home", () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const Beranda()),
                );
              }, 0),
              SizedBox(width: 100),
              // reading list
              _buildNavItem(Icons.bookmark, "Reading List", () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const ReadingList()));
              }, 1),
              SizedBox(width: 100),
              //Profile
              _buildNavItem(Icons.account_circle, "Profile", () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const Profile()));
              }, 2),
              SizedBox(width: 5),
              ]
              )
              )
            ],
          ),
        ),
      ),
  
      appBar: AppBar(
        toolbarHeight: 100.0,
        backgroundColor: Colors.black,
        title: const Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 24, top: 15),
            child: Row(
            children: [
            Icon(Icons.account_circle, color: Colors.white, size: 50.0,),
            SizedBox(width: 15),
            Text('User',
            style: TextStyle(
              color: Colors.white
            ),
            ),
            SizedBox(width: 120),
            Icon(Icons.search, color: Colors.white, size: 50.0),
            SizedBox(width: 5),
            Icon(Icons.notification_add_rounded, color: Colors.white , size: 50.0,),
            ]
            ),
            )
          ],
        ),
      ) ,
    
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.black
        ),
        child: Column(
          children: [
            
          ],
        ),
      ),
    );
  }
}
