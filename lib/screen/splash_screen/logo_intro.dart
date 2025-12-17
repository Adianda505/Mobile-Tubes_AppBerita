import 'package:field_area_proj_mobile/onBoardingScreen.dart';
import 'package:flutter/material.dart';

class intro_logo extends StatefulWidget {
  const intro_logo({super.key});

  @override
  State<intro_logo> createState() => _intro_logoState();
}

class _intro_logoState extends State<intro_logo> {
   @override
    void initState(){
    super.initState();
    Future.delayed(const Duration(seconds: 7), (){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const OnBoardingScreen()),
    );
   }
  );
}
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
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
        child: SafeArea(
          child: Column(
           mainAxisAlignment : MainAxisAlignment.center,
           crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Field Area",
            style: TextStyle(
              fontSize: 30,
              fontWeight:  FontWeight.bold,
              color: Colors.white,
            ),
            )
          ],
        ),
        ),
      ),
    )
  );
  }
}