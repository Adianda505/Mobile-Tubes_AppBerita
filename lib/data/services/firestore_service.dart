import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:field_area_proj_mobile/data/model/article_model.dart';

class FirestoreService {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // FUNGSI UNTUK UPLOAD GAMBAR KE STORAGE
  Future<String> uploadGambarKeStorage(Uint8List imageBytes) async {
    try {
      // 1. Tentukan nama file yang unik
      String fileName = 'berita/${DateTime.now().millisecondsSinceEpoch}.png';
      
      // 2. Buat referensi ke Firebase Storage
      Reference ref = _storage.ref().child(fileName);

      // 3. Upload data (Gunakan putData untuk Uint8List/Web)
      UploadTask uploadTask = ref.putData(
        imageBytes,
        SettableMetadata(contentType: 'image/png'),
      );

      // 4. Tunggu sampai proses upload selesai
      TaskSnapshot snapshot = await uploadTask;

      // 5. Ambil URL download-nya
      String downloadUrl = await snapshot.ref.getDownloadURL();
      
      return downloadUrl;
    } catch (e) {
      throw Exception("Gagal upload gambar: $e");
    }
  }

  // FUNGSI UNTUK AMBIL DATA BERITA (STREAM UNTUK SEARCH & REALTIME)
  // Di dalam class FirestoreService
Stream<List<Berita>> getBerita(String query) {
  return _db.collection('berita')
      .orderBy('dibuat_pada', descending: true)
      .snapshots()
      .map((snapshot) {
        return snapshot.docs.map((doc) {
          // Menggunakan factory constructor Berita.fromFirestore yang Anda buat
          return Berita.fromFirestore(doc.data(), doc.id);
        }).where((berita) {
          // Filter pencarian berdasarkan judul
          return berita.judul.toLowerCase().contains(query.toLowerCase());
        }).toList();
      });
}

  // FUNGSI HAPUS BERITA
  Future<void> hapusBerita(String id) async {
    await _db.collection('berita').doc(id).delete();
  }
}