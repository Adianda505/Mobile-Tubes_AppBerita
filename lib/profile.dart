import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  Future<Map<String, dynamic>?> _getUserData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return null;

    // final doc = await FirebaseFirestore.instance
    //     .collection('users')
    //     .doc(user.uid)
    //     .get();

    // return doc.data();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 0, 0, 0),
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white
        ),
        title: const Text('Profile',
        style: TextStyle(color: Color.fromARGB(255, 255, 255, 255),),
        ),
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
      ),
      body: FutureBuilder(
        future: _getUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text('Data profile tidak ditemukan.'));
          }

          final data = snapshot.data as Map<String, dynamic>;

          return Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Nama: ${data['name'] ?? '-'}',
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 10),
                Text(
                  'Email: ${data['email'] ?? '-'}',
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 10),
                Text(
                  'No HP: ${data['phone'] ?? '-'}',
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
