import 'package:field_area_proj_mobile/profile.dart';
import 'package:flutter/material.dart';
import 'package:field_area_proj_mobile/api/api_service.dart';
import '../widgets/news_card.dart';
import '../data/model/article.dart';
import 'article/reading_list.dart';
import '../screen/profile_user.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Article>> _futureArticles;
  String _currentQuery = 'football';
  String _currentCategory = '';
  final TextEditingController _searchController = TextEditingController();
  
  // State untuk mengontrol tampilan Search Bar
  bool _isSearching = false; 
  int _currentSliderIndex = 0;

  final List<String> _categories = [
    'For You',
    'Top News',
    'Transfer News',
    'Liga Primer',
    'La Liga',
  ];

  int _selectedIndex = 3;
 Widget _buildNavItem(IconData icon, String label, VoidCallback onTap, int index){
  bool isSelected = index == _selectedIndex;
  Color color = isSelected ? const Color.fromARGB(255, 255, 255, 255) : const Color.fromARGB(255, 255, 255, 255);

  return GestureDetector(
   onTap: onTap,
   child: Column(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
     Icon(icon, color: color, size: 26),
     const SizedBox(height: 4),
     Text(
      label,
      style: TextStyle(
       fontSize: 10,
       color: color,
       fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
      ),
     ),
    ],
   ),
  );
 }


  @override
  void initState() {
    super.initState();
    _futureArticles = ApiService().fetchArticles(query: _currentQuery);
  }

  void _searchArticles(String query) {
    setState(() {
      _currentQuery = query.isEmpty ? 'football' : query;
      _futureArticles = ApiService().fetchArticles(
        query: _currentQuery,
        category: _currentCategory,
      );
    });
  }

  void _filterByCategory(String category) {
    String query = _searchController.text.isNotEmpty ? _searchController.text : 'football';
    
    if (category == 'For You') {
      _currentCategory = '';
    } else {
      _currentCategory = category.toLowerCase().replaceAll(' ', '+');
      query = '${_currentCategory} ${query}';
    }

    setState(() {
      _futureArticles = ApiService().fetchArticles(
        query: query,
        category: _currentCategory,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      bottomNavigationBar: Container(
    decoration: BoxDecoration(
     color: Color.fromARGB(255, 33, 1, 47),
    ),
    child: Padding(
     padding: const EdgeInsets.only(bottom: 10.0),
     child: Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
       Padding(
        padding: const EdgeInsets.only(top: 5),
        child: Row(
         // mainAxisSize: MainAxisSize.max,
         // mainAxisAlignment: MainAxisAlignment.spaceAround,
         children: [
          SizedBox(height: 5),
       // Tombol Home (index 0)
       _buildNavItem(Icons.home, "Home", () {
        Navigator.pushReplacement(
         context,
         MaterialPageRoute(builder: (context) => const HomeScreen()),
        );},0),
       SizedBox(width: 100),

       // reading list
       _buildNavItem(Icons.bookmark, "Reading List", () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => const ReadingList())); },1),
       SizedBox(width: 100),

       //Profile
       _buildNavItem(Icons.account_circle, "Profile", () {
        Navigator.push(context, MaterialPageRoute(builder: (context) =>  ProfileScreen())); },2),
       SizedBox(width: 5),
       ]
       )
       )
      ],
     ),
    ),
   ),
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        // Logika Judul vs Search Bar
        title: _isSearching
            ? TextField(
                controller: _searchController,
                autofocus: true, // Langsung fokus keyboard saat muncul
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  hintText: 'Cari berita (e.g. Messi)...',
                  hintStyle: TextStyle(color: Colors.white54),
                  border: InputBorder.none,
                ),
                textInputAction: TextInputAction.search,
                onSubmitted: (value) {
                  _searchArticles(value);
                },
              )
            : const Text(
                'Field Area',
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
        actions: [
          // Tombol Search / Close
          IconButton(
            icon: Icon(
              _isSearching ? Icons.close : Icons.search,
              color: Colors.white,
            ),
            onPressed: () {
              setState(() {
                if (_isSearching) {
                  // Jika sedang mencari dan tombol close ditekan:
                  // 1. Tutup mode search
                  _isSearching = false;
                  // 2. Bersihkan text controller
                  _searchController.clear();
                  // 3. Reset hasil pencarian ke awal (football)
                  _searchArticles('');
                } else {
                  // Buka mode search
                  _isSearching = true;
                }
              });
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Article>>(
        future: _futureArticles,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
                child: Text('Error: ${snapshot.error}',
                    style: const TextStyle(color: Colors.white)));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
                child: Text('Tidak ada berita ditemukan.',
                    style: TextStyle(color: Colors.white)));
          } else {
            // Memisahkan data
            final List<Article> allArticles = snapshot.data!;
            
            // Logic slider: Jika hasil pencarian sedikit (< 5), tampilkan semua di slider
            // Jika banyak, ambil 5.
            final int sliderCount = allArticles.length > 5 ? 5 : allArticles.length;
            final List<Article> sliderArticles = allArticles.take(sliderCount).toList();
            final List<Article> listArticles = allArticles.skip(sliderCount).toList();

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // JIKA HASIL PENCARIAN KOSONG SETELAH FILTER
                if (allArticles.isEmpty)
                   const Expanded(child: Center(child: Text("Tidak ada hasil", style: TextStyle(color: Colors.white)))),

                // SLIDER SECTION
                if (sliderArticles.isNotEmpty) ...[
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                    child: Text(
                      'Trendings', 
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 200,
                    child: PageView.builder(
                      itemCount: sliderArticles.length,
                      onPageChanged: (index) {
                        setState(() {
                          _currentSliderIndex = index;
                        });
                      },
                      itemBuilder: (context, index) {
                        final article = sliderArticles[index];
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 16.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            image: DecorationImage(
                              image: NetworkImage(article.urlToImage),
                              fit: BoxFit.cover,
                              onError: (exception, stackTrace) {},
                            ),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [
                                  Colors.black.withOpacity(0.8),
                                  Colors.transparent,
                                ],
                              ),
                            ),
                            padding: const EdgeInsets.all(16),
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              article.title,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  // Dots Indicator
                  const SizedBox(height: 8),
                  if (sliderArticles.length > 1)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      sliderArticles.length,
                      (index) => Container(
                        width: 8,
                        height: 8,
                        margin: const EdgeInsets.symmetric(horizontal: 2),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _currentSliderIndex == index
                              ? Colors.purple
                              : Colors.grey.shade800,
                        ),
                      ),
                    ),
                  ),
                ],

                // BREAKING NEWS HEADER
                if (listArticles.isNotEmpty)
                const Padding(
                  padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
                  child: Text(
                    'Breaking News',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                // KATEGORI
                SizedBox(
                  height: 40,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    itemCount: _categories.length,
                    itemBuilder: (context, index) {
                      final category = _categories[index];
                      // Logic highlight: Jika kategori cocok dengan yang aktif
                      bool isSelected = false;
                      if (_currentCategory.isEmpty && category == 'For You') {
                        isSelected = true;
                      } else if (_currentCategory.isNotEmpty && 
                                 _currentCategory == category.toLowerCase().replaceAll(' ', '+')) {
                        isSelected = true;
                      }

                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: InkWell(
                          onTap: () => _filterByCategory(category),
                          child: Container(
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? const Color(0xFF4A148C) 
                                  : const Color(0xFF2C2C2C),
                              borderRadius: BorderRadius.circular(20),
                              border: isSelected 
                                  ? Border.all(color: Colors.purpleAccent, width: 1)
                                  : null,
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            child: Center(
                              child: Text(
                                category,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 10),

                // LIST BERITA (SISANYA)
                Expanded(
                  child: listArticles.isEmpty 
                  ? const Center(child: Text("Cek Trendings di atas", style: TextStyle(color: Colors.grey)))
                  : ListView.builder(
                      itemCount: listArticles.length,
                      itemBuilder: (context, index) {
                        return NewsCard(article: listArticles[index]);
                      },
                    ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}