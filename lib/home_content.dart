import 'package:flutter/material.dart';
import 'package:field_area_proj_mobile/data/model/article_model.dart';
import 'package:field_area_proj_mobile/data/services/firestore_service.dart';
// Import halaman detail yang baru dibuat di Langkah 3
import 'package:field_area_proj_mobile/screen/article/article_detail.dart';

class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("News Feed", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        centerTitle: false,
      ),
      // MENGGUNAKAN STREAMBUILDER UNTUK REALTIME UPDATE
      body: StreamBuilder<List<Berita>>(
        stream: FirestoreService().getBerita(""), // Mengambil semua berita (query kosong)
        builder: (context, snapshot) {
          // 1. Loading State
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          
          // 2. Error State
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}", style: const TextStyle(color: Colors.white)));
          }

          // 3. Empty State
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.newspaper, size: 60, color: Colors.grey),
                  SizedBox(height: 10),
                  Text("Belum ada berita.", style: TextStyle(color: Colors.grey)),
                ],
              ),
            );
          }

          // 4. Data Available State
          var listBerita = snapshot.data!;
          
          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            itemCount: listBerita.length,
            itemBuilder: (context, index) {
              var berita = listBerita[index];
              
              // WIDGET CARD BERITA
              return GestureDetector(
                onTap: () {
                  // Navigasi ke Halaman Detail dengan membawa data 'berita'
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailBeritaPage(berita: berita),
                    ),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(color: Colors.black.withOpacity(0.5), blurRadius: 8, offset: const Offset(0, 4)),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Gambar Berita
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                        child: Image.network(
                          berita.urlGambar,
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (c, e, s) => Container(
                            height: 200,
                            color: Colors.grey[800],
                            child: const Center(child: Icon(Icons.broken_image, color: Colors.white)),
                          ),
                        ),
                      ),
                      
                      // Informasi Text
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Kategori (Chip kecil)
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.blueAccent.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                berita.kategori.toUpperCase(),
                                style: const TextStyle(color: Colors.blueAccent, fontSize: 10, fontWeight: FontWeight.bold),
                              ),
                            ),
                            const SizedBox(height: 10),
                            
                            // Judul Berita
                            Text(
                              berita.judul,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 8),
                            
                            // Penulis
                            Text(
                              "Ditulis oleh ${berita.penulis}",
                              style: const TextStyle(color: Colors.grey, fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}