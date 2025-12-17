import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// Pastikan path import ini benar sesuai project Anda
import 'package:field_area_proj_mobile/data/services/firestore_service.dart';

class ArticleCreate extends StatefulWidget {
  const ArticleCreate({super.key});

  @override
  State<ArticleCreate> createState() => _ArticleCreateState();
}

class _ArticleCreateState extends State<ArticleCreate> {
  // 1. Variabel untuk menyimpan data
  String? _selectedCategory;
  Uint8List? _webImage;
  final _picker = ImagePicker();

  // 2. Definisi Controller untuk mengambil teks dari TextField
  final TextEditingController judulController = TextEditingController();
  final TextEditingController isiController = TextEditingController();
  final TextEditingController penulisController = TextEditingController();

  final List<String> _categories = ['Teknologi', 'Kesehatan', 'Edukasi', 'Gaya Hidup'];

  // Fungsi untuk mengambil gambar
  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      var f = await pickedFile.readAsBytes();
      setState(() {
        _webImage = f;
      });
    }
  }

  // Fungsi untuk mempublish berita
  void _publishBerita() async {
    // 1. Validasi Input
    if (_webImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Pilih gambar terlebih dahulu!")),
      );
      return;
    }
    
    // Pastikan controller tidak kosong
    if (_selectedCategory == null || 
        judulController.text.trim().isEmpty || 
        isiController.text.trim().isEmpty ||
        penulisController.text.trim().isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Mohon lengkapi semua field (Judul, Penulis, Isi, Kategori).")),
          );
      return;
    }

    try {
      // Tampilkan Loading
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const Center(child: CircularProgressIndicator()),
      );

      // 2. Upload Gambar via Service
      // Pastikan Service Anda return String URL
      String urlGambar = await FirestoreService().uploadGambarKeStorage(_webImage!);

      // 3. Simpan ke Firestore
      // KUNCI SUKSES: Nama field ('judul', 'url_gambar', dll) HARUS SAMA PERSIS 
      // dengan yang ada di article_model.dart bagian fromFirestore 
      await FirebaseFirestore.instance.collection('berita').add({
        'judul': judulController.text.trim(),
        'isi': isiController.text.trim(),
        'kategori': _selectedCategory,
        'penulis': penulisController.text.trim(),
        'url_gambar': urlGambar, // Perhatikan snake_case ini
        'dibuat_pada': FieldValue.serverTimestamp(), // Agar sorting waktu berhasil
      });

      if (!mounted) return;
      Navigator.pop(context); // Tutup Loading
      Navigator.pop(context); // Kembali ke halaman sebelumnya

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(backgroundColor: Colors.green, content: Text("Berita Berhasil Publish!")),
      );

    } catch (e) {
      if (!mounted) return;
      Navigator.pop(context); // Tutup Loading jika error
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(backgroundColor: Colors.red, content: Text("Gagal: $e")),
      );
    }
  }

  @override
  void dispose() {
    // Bersihkan controller saat widget dihapus dari memori
    judulController.dispose();
    isiController.dispose();
    penulisController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text('Create Article', style: TextStyle(color: Colors.white)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- UPLOAD GAMBAR ---
              const Text('Article Image', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: _webImage == null
                      ? const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.camera_alt, size: 40, color: Colors.grey),
                            Text('Click to upload image', style: TextStyle(color: Colors.grey)),
                          ],
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.memory(_webImage!, fit: BoxFit.cover),
                        ),
                ),
              ),
              const SizedBox(height: 20),

              // --- AUTHOR ---
              const Text('Author Name', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              TextField(
                controller: penulisController, // Tambahkan controller
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
              const SizedBox(height: 20),

              // --- TITLE ---
              const Text('Title', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              TextField(
                controller: judulController, // Tambahkan controller
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
              const SizedBox(height: 20),

              // --- DROPDOWN KATEGORI ---
              const Text('Category', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: _selectedCategory,
                hint: const Text("Select Category"),
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
                items: _categories.map((String category) {
                  return DropdownMenuItem(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _selectedCategory = newValue;
                  });
                },
              ),
              const SizedBox(height: 20),

              // --- ISI ARTIKEL ---
              const Text('Article Content', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              TextField(
                controller: isiController, // Tambahkan controller
                maxLines: 4,
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
              const SizedBox(height: 30),

              // TOMBOL PUBLISH
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                  onPressed: _publishBerita, // Hubungkan ke fungsi publish
                  child: const Text('Publish Article', style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}