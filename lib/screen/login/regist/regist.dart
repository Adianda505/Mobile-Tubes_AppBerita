import 'package:field_area_proj_mobile/screen/home_screen.dart';
import 'package:field_area_proj_mobile/screen/login/regist/login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Regist extends StatefulWidget {
 const Regist({super.key});

 @override
 State<Regist> createState() => RegistState();
}

class RegistState extends State<Regist> {
  final namaController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final auth = FirebaseAuth.instance;

Future<void> _register() async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );

    // 2. Simpan Data Tambahan ke Firestore
    await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set({
      'name': namaController.text.trim(), // Anda bisa tambah controller nama di form regist
      'email': emailController.text.trim(),
      'phone': '-', // Default kosong
      'uid': userCredential.user!.uid,
    });
      if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    }
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? 'Register Gagal')),
      );
    }
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
        height: 350,
        decoration: BoxDecoration(
         color: Colors.black,
         borderRadius: BorderRadius.circular(15),
        ),
         
        child: Column(
         children: [
         const SizedBox(height: 20),

          Align(
        alignment: Alignment.centerLeft,
        child: SizedBox(
         width: 100,
         child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
           const Text(
            
            'Nama',
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
         controller: namaController,
         style: TextStyle(
          color: Colors.white
         ),
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
         controller: emailController,
         style: TextStyle(
          color: Colors.white
         ),
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
          controller: passwordController,
          style: TextStyle(
            color: Colors.white
          ),
          obscureText: true,
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
          
         onPressed: _register, 
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
            'Already Have An Account?',
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