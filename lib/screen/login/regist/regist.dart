import 'package:field_area_proj_mobile/screen/login/regist/login.dart';
import 'package:flutter/material.dart';

class Regist extends StatelessWidget {
const Regist({super.key});


void login(){

}

 @override
 Widget build(BuildContext context) {
  return Scaffold(
     body: Container(
      //Background
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

    child: Column(
     mainAxisAlignment: MainAxisAlignment.center,
     crossAxisAlignment: CrossAxisAlignment.center,
     children: [
      Text(
       'Welcome!',
       style: TextStyle(
        color: Colors.white
       ),
      ),
      Text(
       'Your Journey Starts Here. Take the first Step',
       style: TextStyle(
        color: Colors.white,
       ),
      ),

      SizedBox(height: 50),
      //Form Login
      Form(
       child: Container(
        width: 323,
        height: 300,
        decoration: BoxDecoration(
         color: Colors.black,
         borderRadius: BorderRadius.circular(15),
        ),
         
        child: Column(
         children: [
         const SizedBox(height: 20),
       SizedBox(height: 20),
       Align(
        alignment: Alignment.centerLeft,
        child: SizedBox(
         width: 100,
         child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
           const Text(
            'Email',
             style: TextStyle(
             color: Colors.white,
        ),
       ),
         ],
       ))
       ),

       SizedBox(height: 2),
       SizedBox(
        width: 262,
        height: 55,   
        child: TextField(
         decoration: InputDecoration(
          border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50.0)
          ),

          enabledBorder: OutlineInputBorder(
           borderRadius: BorderRadius.circular(50.0),
           borderSide: const BorderSide(
            color: Color.fromARGB(255, 67, 18, 89),
            width: 2,
           )
          ),
          filled: false,
          // border: Border.all( color:Color.fromARGB(255, 67, 18, 89)),
         ),
        ),
       ),

      
      Align(
        alignment: Alignment.centerLeft,
        child: SizedBox(
         width: 125,
         child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
           const Text(
            'Password',
             style: TextStyle(
             color: Colors.white,
        ),
       ),
          ],
         ))
       
       ),
       const SizedBox(height: 5),

      
       SizedBox(
        width: 262,
        height: 55,
        child: TextField(
         decoration: InputDecoration(
          border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50.0)
          ),
          enabledBorder: OutlineInputBorder(
           borderRadius: BorderRadius.circular(50.0),
           borderSide: const BorderSide(
            color: Color.fromARGB(255, 67, 18, 89),
           width: 2,
           )
          ),
          filled: false,
         ),
        ),
       ),

        SizedBox(height: 10),
         
         SizedBox( 
         width: 267,
         height: 40, 
         child: ElevatedButton(
          
         onPressed: login, 
         style: ElevatedButton.styleFrom(
          backgroundColor: Color.fromARGB(255, 67, 18, 89)
         ),
         child: const Text('Sign Up',
            textAlign: TextAlign.center,
            style: TextStyle(
             color: Colors.white,
            ),
         ),
         )
         ),
         

        ],
        ),
       )
       ),

              
       SizedBox(height: 10),
      Align(
        alignment: Alignment(0, 10.0),
        child: SizedBox(
         width: 290,
        
         child: GestureDetector(
          onTap: (){
           Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
          },
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
           const Text(
            'Already Have An Account',
             style: TextStyle(
              fontSize: 12,
             color: Colors.white,
        ),
       ),
          ],
          ),
         ))
       
       ),
     ],
    ),
   ),
  );
 }
}