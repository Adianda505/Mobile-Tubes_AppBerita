import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:share_plus/share_plus.dart'; // Package untuk share
import '../data/model/article.dart';
import '../provider/bookmark_provider.dart';
import 'package:provider/provider.dart';

class DetailScreen extends StatefulWidget {
  final Article article;

  const DetailScreen({super.key, required this.article});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late final WebViewController controller;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..loadRequest(Uri.parse(widget.article.url))
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (String url) {
            setState(() {
              _isLoading = false;
            });
          },
        ),
      );
  }

  // Fungsi untuk fitur Share
  void _shareArticle() {
    Share.share('Check out this news: ${widget.article.title}\n${widget.article.url}');
  }

  void _bookmarkArticle() {
  // Memanggil provider untuk menambah/menghapus bookmark
  context.read<BookmarkProvider>().toggleBookmark(widget.article);

  // Menampilkan pesan konfirmasi
  final isSaved = context.read<BookmarkProvider>().isBookmarked(widget.article);
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(isSaved ? 'Saved to Reading List' : 'Removed from Reading List'),
      duration: const Duration(seconds: 1),
    ),
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Menyesuaikan tema gelap
      appBar: AppBar(
        title: Text(widget.article.sourceName),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Stack(
        children: [
          // 1. Konten WebView
          WebViewWidget(controller: controller),
          
          // 2. Loading Indicator
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(color: Colors.purple),
            ),

          // 3. Navbar Melayang (Floating Action Bar Custom)
          Positioned(
            bottom: 30, // Jarak dari bawah
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: const Color(0xFFF3E5F5), // Warna ungu sangat muda sesuai gambar
                  borderRadius: BorderRadius.circular(40), // Bentuk kapsul
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min, // Agar container menciut sesuai isi
                  children: [
                    // Tombol Bookmark
                    IconButton(
                      icon: const Icon(Icons.bookmark_add_outlined, color: Color(0xFF4A148C)),
                      onPressed: _bookmarkArticle,
                    ),
                    const SizedBox(width: 40), // Jarak antar tombol sesuai gambar
                    // Tombol Share
                    IconButton(
                      icon: const Icon(Icons.share_outlined, color: Color(0xFF4A148C)),
                      onPressed: _shareArticle,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}