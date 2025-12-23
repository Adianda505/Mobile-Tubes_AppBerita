import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

// class AuthService {
//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   Future<UserCredential?> signInWithGoogle() async {
//     try {
//       // Pastikan memanggil GoogleSignIn() dengan tanda kurung
//       final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

//       if (googleUser == null) return null;

//       final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

//       // Gunakan AuthProvider.credential dan pastikan token tidak null (!)
//       final AuthCredential credential = GoogleAuthProvider.credential(
//         accessToken: googleAuth.accessToken,
//         idToken: googleAuth.idToken,
//       );

//       return await _auth.signInWithCredential(credential);
//     } catch (e) {
//       print("Detail Error: $e");
//       return null;
//     }
//   }
// }

// extension on GoogleSignIn {
//   Future<GoogleSignInAccount?> signIn() {}
// }