import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Tambahkan ini

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
                if (context.mounted){
                  Navigator.of(context).popUntil((route) => route.isFirst);
                }
              },
              child: const Text("Logout"),
            ),
          ],
        );
      },
    );
  }

  Future<Map<String, dynamic>?> _getUserData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return null;

    // Mengambil data dari koleksi 'users' berdasarkan UID login
    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();

    return doc.data();
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
      body: FutureBuilder<Map<String, dynamic>?>(
        future: _getUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // Jika user baru daftar dan datanya belum ada di Firestore
          if (!snapshot.hasData || snapshot.data == null) {
            final user = FirebaseAuth.instance.currentUser;
            return Center(
              child: Text(
                'Email: ${user?.email}\n(Data tambahan belum diisi)',
                style: const TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            );
          }

          final data = snapshot.data!;

          return Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildProfileItem('Nama', data['name']),
                _buildProfileItem('Email', data['email']),
                _buildProfileItem('No HP', data['phone']),
              ],
            ),
          );
        },
      ),
    );
  }

  // Helper widget agar kode lebih rapi
  Widget _buildProfileItem(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey, fontSize: 14)),
          Text(value ?? '-', style: const TextStyle(color: Colors.white, fontSize: 18)),
          const Divider(color: Colors.white24),
        
        ],
      ),
    );

    
  }
}