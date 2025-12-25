import 'package:field_area_proj_mobile/firebase_options.dart';
import 'package:field_area_proj_mobile/beranda.dart';
import 'package:field_area_proj_mobile/onBoardingScreen.dart';
import 'package:field_area_proj_mobile/screen/home_screen.dart';
import 'package:field_area_proj_mobile/screen/login/regist/login.dart';
import 'package:field_area_proj_mobile/screen/splash_screen/logo_intro.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'provider/bookmark_provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => BookmarkProvider(),
        ),
      ],
      child:const MyApp()
    ),
      );
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,  
      home: const intro_logo(),
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
        return const HomeScreen();
       }
       return const Login();
      }
    );     
  }
}
