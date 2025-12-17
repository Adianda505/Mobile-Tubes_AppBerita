import 'package:cloud_firestore/cloud_firestore.dart';

class Berita {
  final String id;
  final String judul;
  final String isi;
  final String kategori;
  final String penulis;
  final String urlGambar; 
  final DateTime dibuatPada;

  Berita({
    required this.id,
    required this.judul,
    required this.isi,
    required this.kategori,
    required this.penulis,
    required this.urlGambar,
    required this.dibuatPada,
  });

  factory Berita.fromFirestore(Map<String, dynamic> data, String documentId) {
    return Berita(
      id: documentId,
      judul: data['judul'] ?? '',
      isi: data['isi'] ?? '',
      kategori: data['kategori'] ?? '',
      penulis: data['penulis'] ?? '',
      urlGambar: data['url_gambar'] ?? '', // Ambil dari Firestore
      dibuatPada: (data['dibuat_pada'] as Timestamp).toDate(),
    );
  }

  // Fungsi untuk mengubah objek Berita menjadi Map untuk disimpan ke Firestore
  Map<String, dynamic> toMap() {
    return {
      'judul': judul,
      'isi': isi,
      'kategori': kategori,
      'penulis': penulis,
      'url_gambar': urlGambar,
      'dibuat_pada': Timestamp.fromDate(dibuatPada),
    };
  }
}