import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';



// class ProfilePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: StreamBuilder<User?>(
//         stream: FirebaseAuth.instance.authStateChanges(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           }
          
//           if (snapshot.hasData) {
//             // JIKA SUDAH LOGIN
//             return UserProfileWidget(user: snapshot.data!);
//           } else {
//             // JIKA BELUM LOGIN
//             return LoginOptionsWidget();
//           }
//         },
//       ),
//     );
//   }
// }

// class LoginOptionsWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Text("Silahkan Login"),
//         ElevatedButton(
//           onPressed: () { /* Navigasi ke Form Login Biasa */ },
//           child: Text("Login dengan Email"),
//         ),
//         OutlinedButton(
//           onPressed: () async {
//             await AuthService().signInWithGoogle();
//           },
//           child: Text("Login dengan Google"),
//         ),
//       ],
//     );
//   }
// }