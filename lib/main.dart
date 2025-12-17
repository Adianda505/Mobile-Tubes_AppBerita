import 'package:field_area_proj_mobile/firebase_options.dart';
import 'package:field_area_proj_mobile/screen/admin/create_article.dart';
import 'package:field_area_proj_mobile/screen/admin/page_admin.dart';
import 'package:field_area_proj_mobile/screen/article/article_detail.dart';
import 'package:field_area_proj_mobile/screen/article/reading_list.dart';
import 'package:field_area_proj_mobile/beranda.dart';
import 'package:field_area_proj_mobile/screen/login/regist/login.dart';
import 'package:field_area_proj_mobile/screen/login/regist/regist.dart';
import 'package:field_area_proj_mobile/onBoardingScreen.dart';
import 'package:field_area_proj_mobile/screen/login/regist/login.dart';
import 'package:field_area_proj_mobile/profile.dart';
import 'package:field_area_proj_mobile/screen/splash_screen/logo_intro.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,  
      home: PageAdmin(),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot){
       if(snapshot.connectionState == ConnectionState.waiting){
        return const Center(child: CircularProgressIndicator());
       } 
       if (snapshot.hasData){
        return const BerandaPage(title: 'Beranda');
       }
       return const Login();
      }
    );     
  }
}
