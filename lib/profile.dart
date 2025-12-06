import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Field Area',
        home: ProfilePage(),
        
    );    
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Row(
          children: [
            Icon(Icons.arrow_back, color: Colors.white,),
            SizedBox(width: 15),
            Text('profile',
            style: TextStyle(
              color: Colors.white
            ),
            ),
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
            Padding(
              padding: EdgeInsetsGeometry.only(top: 50)
              ),
            Image.asset('assets/images/profile_akun.png', height: 200, width: 200),
            Text(''),
            Text(''),
            Text(''),
            Text(''),
          ],
        ),
      ),
    );
  }
}