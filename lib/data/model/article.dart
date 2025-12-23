class Article {
  final String title;
  final String description;
  final String urlToImage;
  final String url;
  final String publishedAt;
  final String sourceName;

  Article({
    required this.title,
    required this.description,
    required this.urlToImage,
    required this.url,
    required this.publishedAt,
    required this.sourceName,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    // Memastikan data tidak null sebelum menggunakannya
    return Article(
      title: json['title'] ?? 'Judul Tidak Tersedia',
      description: json['description'] ?? 'Deskripsi Tidak Tersedia',
      urlToImage: json['urlToImage'] ?? 'https://via.placeholder.com/600x400', // Gambar placeholder jika null
      url: json['url'] ?? '',
      publishedAt: json['publishedAt'] ?? '',
      sourceName: json['source']['name'] ?? 'Sumber Tidak Diketahui',
    );
  }
}