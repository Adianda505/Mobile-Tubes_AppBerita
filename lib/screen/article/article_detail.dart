import 'package:flutter/material.dart';
import 'package:field_area_proj_mobile/data/model/article_model.dart';
import 'package:intl/intl.dart'; // Tambahkan package intl di pubspec.yaml untuk format tanggal

class DetailBeritaPage extends StatelessWidget {
  final Berita berita;

  const DetailBeritaPage({super.key, required this.berita});

  @override
  Widget build(BuildContext context) {
    // Format tanggal agar rapi
    String formattedDate = DateFormat('dd MMM yyyy, HH:mm').format(berita.dibuatPada);

    return Scaffold(
      backgroundColor: Colors.black, // Tema gelap
      body: CustomScrollView(
        slivers: [
          // Bagian App Bar dengan Gambar Parallax
          SliverAppBar(
            expandedHeight: 300.0,
            floating: false,
            pinned: true,
            backgroundColor: Colors.black,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                berita.kategori,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  backgroundColor: Colors.black45,
                ),
              ),
              background: Image.network(
                berita.urlGambar,
                fit: BoxFit.cover,
                errorBuilder: (c, e, s) => const Icon(Icons.broken_image, size: 100, color: Colors.grey),
              ),
            ),
          ),
          // Bagian Isi Berita
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Judul
                  Text(
                    berita.judul,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  
                  // Info Penulis & Tanggal
                  Row(
                    children: [
                      const Icon(Icons.person, color: Colors.grey, size: 16),
                      const SizedBox(width: 5),
                      Text(berita.penulis, style: const TextStyle(color: Colors.grey)),
                      const SizedBox(width: 15),
                      const Icon(Icons.access_time, color: Colors.grey, size: 16),
                      const SizedBox(width: 5),
                      Text(formattedDate, style: const TextStyle(color: Colors.grey)),
                    ],
                  ),
                  const Divider(color: Colors.grey, height: 30),
                  
                  // Isi Konten
                  Text(
                    berita.isi,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                      height: 1.5, // Spasi antar baris agar enak dibaca
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}