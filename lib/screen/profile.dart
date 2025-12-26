import 'package:field_area_proj_mobile/screen/login/regist/login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  Future<void> _confirmLogout(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          title: const Text(
            "Konfirmasi Logout",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: const Text("Apakah kamu yakin ingin keluar dari akun ini?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Batal"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () async {
                Navigator.pop(context);
                await FirebaseAuth.instance.signOut();
                if (context.mounted) {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const Login()),
                      (route) => false);
                }
              },
              child: const Text("Logout"),
            ),
          ],
        );
      },
    );
  }

  // Fungsi untuk mengambil data Profile (Prioritas: Firebase Auth -> Firestore)
  Future<Map<String, dynamic>> _getProfileData() async {
    final user = FirebaseAuth.instance.currentUser;
    
    // Default data dari Firebase Auth (Google Account)
    Map<String, dynamic> userData = {
      'name': user?.displayName ?? "Pengguna",
      'email': user?.email ?? "Email tidak tersedia",
      'photoUrl': user?.photoURL, // Bonus: bisa ambil foto profil Google
    };

    try {
      // Mencoba mengambil data tambahan dari Firestore jika ada
      if (user != null) {
        final doc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        if (doc.exists && doc.data() != null) {
          final data = doc.data()!;
          // Jika di Firestore ada nama, kita bisa gunakan itu atau tetap pakai Google
          if (data['name'] != null) userData['name'] = data['name'];
        }
      }
    } catch (e) {
      debugPrint("Error fetching Firestore: $e");
    }

    return userData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text('Profile', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            onPressed: () => _confirmLogout(context),
            icon: const Icon(Icons.logout),
            tooltip: "Logout",
          ),
        ],
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _getProfileData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: Colors.white));
          }

          final data = snapshot.data!;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                // Menampilkan Foto Profil Google jika ada
                if (data['photoUrl'] != null)
                  Center(
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(data['photoUrl']),
                    ),
                  )
                else
                  const Center(
                    child: CircleAvatar(
                      radius: 50,
                      child: Icon(Icons.person, size: 50),
                    ),
                  ),
                
                const SizedBox(height: 30),

                _buildProfileItem('Nama', data['name']),
                _buildProfileItem('Email', data['email']),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildProfileItem(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey, fontSize: 14)),
          const SizedBox(height: 5),
          Text(value ?? '-',
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500)),
          const Divider(color: Colors.white24),
        ],
      ),
    );
  }
}