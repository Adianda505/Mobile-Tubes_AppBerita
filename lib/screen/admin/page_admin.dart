import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:field_area_proj_mobile/data/model/article_model.dart';
import 'package:field_area_proj_mobile/data/services/firestore_service.dart';
//import 'package:field_area_proj_mobile/screen/admin/';

class PageAdmin extends StatefulWidget {
  const PageAdmin({super.key});

  @override
  State<PageAdmin> createState() => _AdminPageState();
}

class _AdminPageState extends State<PageAdmin> {
  // 1. Tambahkan controller untuk kolom pencarian
  final TextEditingController textSearchController = TextEditingController();
  String _searchKeyword = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: textSearchController,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            hintText: "Cari judul berita...",
            hintStyle: TextStyle(color: Colors.grey),
            prefixIcon: Icon(Icons.search, color: Colors.white),
          ),
          onChanged: (value) {
            // 2. Update state setiap kali mengetik agar StreamBuilder reload
            setState(() {
              _searchKeyword = value;
            });
          },
        ),
      ),
      body: StreamBuilder<List<Berita>>(
        // 3. Gunakan variabel _searchKeyword ke dalam fungsi getBerita
        stream: FirestoreService().getBerita(_searchKeyword),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("Tidak ada berita ditemukan"));
          }

          var listBerita = snapshot.data!;
          return ListView.builder(
            itemCount: listBerita.length,
            itemBuilder: (context, index) {
              var berita = listBerita[index];
              return ListTile(
                leading: Image.network(berita.urlGambar, width: 50, errorBuilder: (c, e, s) => Icon(Icons.broken_image)),
                title: Text(berita.judul),
                subtitle: Text(berita.penulis),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => FirestoreService().hapusBerita(berita.id),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
