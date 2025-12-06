import 'package:field_area_proj_mobile/beranda.dart';
import 'package:field_area_proj_mobile/login/regist/login.dart';
import 'package:field_area_proj_mobile/login/regist/regist.dart';
import 'package:field_area_proj_mobile/onBoardingScreen.dart';
import 'package:field_area_proj_mobile/login/regist/login.dart';
import 'package:field_area_proj_mobile/profile.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,  
      home: Beranda(),
     
    );
  }
}



