import 'package:flutter/material.dart';
import 'package:sampahku_flutter/color/app_color.dart';
import 'package:sampahku_flutter/model/article.dart';
import 'package:sampahku_flutter/model/blog_post.dart';
import 'package:sampahku_flutter/repository/remote/api_service.dart';
import 'package:sampahku_flutter/view/detail_article_screen.dart';

class ArticleScreen extends StatefulWidget {
  const ArticleScreen({super.key});

  @override
  State<ArticleScreen> createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen> {
  List<BlogPost> futureArticles = [];
  List<BlogPost> filteredArticles = [];
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Fetch articles when the screen is initialized
    _fetchArticles();
  }

  @override
  void dispose() {
    _searchController.removeListener(() {});
    _searchController
        .dispose(); // Dispose controller untuk mencegah memory leak
    super.dispose();
  }

  // Fetch articles from the API
  Future<void> _fetchArticles() async {
    try {
      final articles = await WordPressApi().fetchPosts();
      setState(() {
        futureArticles = articles;
        filteredArticles =
            articles; // Initialize filteredArticles with the fetched data
      });
    } catch (error) {
      // Handle any errors if necessary
      print('Error fetching articles: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    _searchController.addListener(() {
      _filterArticles(
          _searchController.text); // Menambahkan listener pada perubahan input
    });
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.thirthyColor,
        title: Text("Artikel Edukasi Sampah",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: "Cari Artikel",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(60),
                ),
                contentPadding: EdgeInsets.symmetric(
                    vertical: 16.0), // Menjaga agar padding vertikal seimbang
              ),
            ),

            SizedBox(
              height: 10,
            ),
            // Displaying the list of articles
            futureArticles.isEmpty
                ? Center(child: CircularProgressIndicator())
                : Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: filteredArticles.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.all(5),
                          child: InkWell(
                            onTap: () {
                              _goToDetailArticle(filteredArticles[index]);
                            },
                            child: Card(
                              child: SizedBox(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                        decoration: BoxDecoration(
                                          color: Colors.grey,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(12),
                                            bottomLeft: Radius.circular(12),
                                          ),
                                        ),
                                        height: 100,
                                        width: 100,
                                        clipBehavior: Clip.hardEdge,
                                        child: FutureBuilder(
                                            future: futureArticles[index]
                                                .fetchFeaturedImage(),
                                            builder: (context, snapshot) {
                                              if (snapshot.connectionState ==
                                                  ConnectionState.done) {
                                                return futureArticles[index]
                                                            .featuredMediaId !=
                                                        0
                                                    ? Image.network(
                                                        futureArticles[index]
                                                            .featuredImage
                                                            .sourceUrl,
                                                        fit: BoxFit.cover)
                                                    : Image.network(
                                                        "https://via.placeholder.com/100");
                                              } else {
                                                return Image.network(
                                                    "https://via.placeholder.com/100");
                                              }
                                            })),
                                    Expanded(
                                        child: Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            filteredArticles[index].title,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1, // Limit to 1 line
                                            style: TextStyle(
                                              color: AppColor.secondaryColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                            ),
                                          ),
                                          Text(
                                            removeHtmlTags(_getExcerpt(
                                                filteredArticles[index]
                                                    .excerpt)), // Abstrak konten
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2, // Limit to 2 lines
                                            style: TextStyle(
                                              color: AppColor.primaryColor,
                                              fontWeight: FontWeight.normal,
                                              fontSize: 14,
                                            ),
                                          ),
                                          Text(
                                            "Baca Selengkapnya",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.normal,
                                              decoration:
                                                  TextDecoration.underline,
                                              fontSize: 12,
                                            ),
                                          )
                                        ],
                                      ),
                                    ))
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  String _getExcerpt(String content) {
    return content.length > 300 ? content.substring(0, 300) + '...' : content;
  }

  // Fungsi untuk menghapus tag HTML
  String removeHtmlTags(String htmlText) {
    final regExp = RegExp(r'<[^>]*>');
    return htmlText.replaceAll(regExp, '');
  }

  void _goToDetailArticle(BlogPost article) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailArticleScreen(article: article),
      ),
    );
  }

  // Fungsi untuk filter artikel berdasarkan pencarian
  void _filterArticles(String query) {
    if (query.isEmpty) {
      setState(() {
        filteredArticles =
            futureArticles; // Jika kosong, tampilkan semua artikel
      });
    } else {
      setState(() {
        filteredArticles = futureArticles
            .where((article) =>
                article.title.toLowerCase().contains(query.toLowerCase()) ||
                removeHtmlTags(article.excerpt)
                    .toLowerCase()
                    .contains(query.toLowerCase()))
            .toList();
      });
    }
  }
}
