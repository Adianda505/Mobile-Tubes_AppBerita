import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_core/firebase_core.dart';

class GoogleAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    //clientId: '66775041808-7ns5o91odp4io6engvpf8qd8q4hu0bqg.apps.googleusercontent.com',
   serverClientId: '200965913510-6rqqcufencpg5f6gvm1fk7i90erfb256.apps.googleusercontent.com',
  );

  // Fungsi untuk Login
  Future<UserCredential?> signInWithGoogle() async {
    try {
      // 1. Membuka jendela pilihan akun Google
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      // Jika user menekan tombol back/cancel
      if (googleUser == null) return null;

      // 2. Mendapatkan detail autentikasi dari akun yang dipilih
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // 3. Membuat kredensial untuk dikirim ke Firebase
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // 4. Login ke Firebase dengan kredensial tersebut
      return await _auth.signInWithCredential(credential);
      
    } catch (e) {
      print("Error Login Google: $e");
      return null;
    }
  }

  // Fungsi untuk Logout
  Future<void> signOut() async {
    try {
      await _googleSignIn.signOut(); // Logout dari akun Google
      await _auth.signOut();         // Logout dari Firebase
    } catch (e) {
      print("Error Logout: $e");
    }
  }
} 