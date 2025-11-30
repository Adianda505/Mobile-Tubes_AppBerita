import 'package:flutter/material.dart';

class introPage3 extends StatelessWidget {
  const introPage3({super.key});

  @override
  Widget build(BuildContext context) {
   
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
        child: SafeArea( 
          child: Column(
           
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
           
              Padding(
                padding: EdgeInsets.only(top: screenHeight * 0.1), 
                child: Image.asset(
                  "assets/images/time.png",
                  
                  height: screenHeight * 0.45, 
                ),
              ),

              
              const Spacer(flex: 1), 

              
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  "Your daily football companion",
                  textAlign: TextAlign.justify,
                  style: const TextStyle(
                    fontSize: 24, 
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              
              
              const SizedBox(height: 15),

            
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 45.0),
                child: Text(
                  "Discover match results, breaking news, transfers,and everything you need to stay in the game.",

                  textAlign: TextAlign.left, 
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),

            
              const Spacer(flex: 2), 

              
              const SizedBox(height: 100),

            ],
          ),
        ),
      ),
    );
  }
}