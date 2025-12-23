import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// Pastikan kedua import di bawah ini mengarah ke file yang benar
import '../../widgets/news_card.dart';
import '../../data/model/article.dart'; // Tambahkan ini jika NewsCard butuh referensi tipe data
import '../../provider/bookmark_provider.dart';

class ReadingList extends StatelessWidget {
  const ReadingList({super.key});

  @override
  Widget build(BuildContext context) {
    // Gunakan context.watch agar list otomatis terupdate saat ada perubahan
    final bookmarkProvider = context.watch<BookmarkProvider>();
    final List<Article> savedArticles = bookmarkProvider.bookmarkedArticles;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Reading List',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: savedArticles.isEmpty
          ? const Center(
              child: Text(
                'No articles saved yet.',
                style: TextStyle(color: Colors.grey),
              ),
            )
          : ListView.builder(
              itemCount: savedArticles.length,
              itemBuilder: (context, index) {
                // Pastikan parameter 'article:' sesuai dengan yang ada di NewsCard
                return NewsCard(article: savedArticles[index]);
              },
            ),
    );
  }
}