import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../data/model/article.dart';
import '../screen/detail_screen.dart';

class NewsCard extends StatelessWidget {
  final Article article;

  const NewsCard({super.key, required this.article});

  // Fungsi helper untuk menghitung "Waktu yang lalu" (e.g. 2 hours ago)
  // Jika ingin tetap tanggal lengkap, gunakan method _formatDate lama Anda.
  String _timeAgo(String dateString) {
    try {
      final dateTime = DateTime.parse(dateString).toLocal();
      final difference = DateTime.now().difference(dateTime);

      if (difference.inDays > 0) {
        return '${difference.inDays} days ago';
      } else if (difference.inHours > 0) {
        return '${difference.inHours} hours ago';
      } else if (difference.inMinutes > 0) {
        return '${difference.inMinutes} mins ago';
      } else {
        return 'Just now';
      }
    } catch (e) {
      return dateString;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.black, // Mengatur background card menjadi hitam sesuai gambar
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12), // Radius border card
      ),
      elevation: 0, // Flat design sesuai gambar (tanpa bayangan tebal)
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailScreen(article: article),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // BAGIAN KIRI: TEKS (Judul & Info)
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Judul Berita
                    Text(
                      article.title,
                      style: const TextStyle(
                        fontSize: 16, // Ukuran font disesuaikan
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // Teks putih
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 16), // Jarak antara judul dan footer
                    
                    // Footer: Icon User + Media Name + Waktu
                    Row(
                      children: [
                        // Avatar kecil (lingkaran abu-abu)
                        const CircleAvatar(
                          radius: 10,
                          backgroundColor: Colors.grey,
                          child: Icon(Icons.person, size: 12, color: Colors.white),
                        ),
                        const SizedBox(width: 8),
                        
                        // Nama Media
                        Flexible(
                          child: Text(
                            article.sourceName,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.white70, // Putih agak transparan
                              fontWeight: FontWeight.w500,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 8),
                        
                        // Waktu (Time Ago)
                        Text(
                          _timeAgo(article.publishedAt),
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[500],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              const SizedBox(width: 12), // Jarak antara Teks dan Gambar

              // BAGIAN KANAN: GAMBAR
              ClipRRect(
                borderRadius: BorderRadius.circular(12), // Sudut gambar melengkung
                child: Image.network(
                  article.urlToImage,
                  width: 110, // Lebar gambar fixed
                  height: 80, // Tinggi gambar fixed
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 110,
                      height: 80,
                      color: Colors.grey[800],
                      child: const Icon(Icons.broken_image, color: Colors.white54),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}