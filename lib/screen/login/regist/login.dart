import 'package:field_area_proj_mobile/screen/home_screen.dart';
import 'package:field_area_proj_mobile/screen/login/regist/regist.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:field_area_proj_mobile/api/services/goggle_auth.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _auth = FirebaseAuth.instance;
 

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 1. Background Gradient
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 67, 18, 89),
                  Color.fromARGB(255, 0, 0, 0),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          
          // 2. Content
          Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Login Here!',
                    style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    'Use your email and Password to log in',
                    style: TextStyle(color: Colors.white70),
                  ),
                  const SizedBox(height: 50),
                  
                  // Form Container
                  Container(
                    width: 323,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 10),
                        
                        // Email Field
                        _buildLabel('Email'),
                        const SizedBox(height: 5),
                        _buildTextField(_emailController, false),
                        
                        const SizedBox(height: 20),
                        
                        // Password Field
                        _buildLabel('Password'),
                        const SizedBox(height: 5),
                        _buildTextField(_passwordController, true),
                        
                        // Text('Forget password?',style: TextStyle(color: Colors.white),),

                        const SizedBox(height: 25),
                        
                        // Login Button
                        SizedBox(
                          width: 267,
                          height: 45,
                          child: ElevatedButton(
                            onPressed: _login,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color.fromARGB(255, 67, 18, 89),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                            child: const Text(
                              'Login',
                              style: TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ),
                        ),
                        
                        const SizedBox(height: 15),
                        
                        // Register Link
                        GestureDetector(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const Regist()),
                          ),
                          child: const Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              "Don't have an account?",
                              style: TextStyle(color: Colors.white, fontSize: 12),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 50),
                  // Placeholder for Google Login or other social
                   Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    
                    children: [
                    ElevatedButton(
                    onPressed: () async {
                    UserCredential? user = await GoogleAuthService().signInWithGoogle();
                    if (!mounted) return;
                    if (user != null) {
                    print("Berhasil Login: ${user.user!.displayName}");
                    // Pindah ke halaman Home jika berhasil
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                  } else {
                    print("Login Dibatalkan atau Gagal");
                  }
                },
                    child: Image(image: AssetImage('assets/images/goggle.png'), width: 50, height: 50,),
                    )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper Widget untuk Label agar kode tidak berulang
  Widget _buildLabel(String label) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Text(
          label,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  // Helper Widget untuk TextField agar kode lebih bersih
  Widget _buildTextField(TextEditingController controller, bool isPassword) {
    return SizedBox(
      width: 262,
      height: 55,
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50.0),
            borderSide: const BorderSide(
              color: Color.fromARGB(255, 67, 18, 89),
              width: 2,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50.0),
            borderSide: const BorderSide(
              color: Colors.purpleAccent,
              width: 2,
            ),
          ),
        ),
      ),
    );
  }
}