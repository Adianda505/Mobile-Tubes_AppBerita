import 'package:flutter/material.dart';
import '../data/model/article.dart';

class BookmarkProvider extends ChangeNotifier {
  final List<Article> _bookmarkedArticles = [];

  List<Article> get bookmarkedArticles => _bookmarkedArticles;

  void toggleBookmark(Article article) {
    final isExist = _bookmarkedArticles.any((item) => item.url == article.url);
    if (isExist) {
      _bookmarkedArticles.removeWhere((item) => item.url == article.url);
    } else {
      _bookmarkedArticles.add(article);
    }
    notifyListeners();
  }

  bool isBookmarked(Article article) {
    return _bookmarkedArticles.any((item) => item.url == article.url);
  }
}