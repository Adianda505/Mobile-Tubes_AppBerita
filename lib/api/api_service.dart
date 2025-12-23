import 'dart:convert';
import 'package:http/http.dart' as http;
import '../data/model/article.dart';

class ApiService {
  // GANTI DENGAN KUNCI API ANDA!
  static const String API_KEY = 'eb12ad14dcd348c29200600aae2f8cb4'; 
  // Contoh API NewsAPI, kita akan cari berita dengan kata kunci 'football' atau 'soccer'
  static const String BASE_URL = 'https://newsapi.org/v2/everything';

  Future<List<Article>> fetchArticles({String query = 'football', String category = ''}) async {
    // Kita akan fokus pada query 'football' atau 'soccer' untuk memastikan berita sepak bola
    // Anda bisa menyesuaikan query berdasarkan kategori yang Anda inginkan (misal: 'premier league', 'laliga', dll)
    String url = '$BASE_URL?q=$query $category&sortBy=publishedAt&apiKey=$API_KEY&language=en';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['articles'] != null) {
        List<Article> articles = (data['articles'] as List)
            .map((e) => Article.fromJson(e))
            .toList();
        return articles;
      } else {
        throw Exception('Format respons API tidak valid');
      }
    } else {
      // Jika respons bukan 200 OK, lempar exception
      throw Exception('Gagal memuat berita. Status: ${response.statusCode}');
    }
  }
}