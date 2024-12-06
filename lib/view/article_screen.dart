import 'package:flutter/material.dart';
import 'package:sampahku_flutter/color/app_color.dart';
import 'package:sampahku_flutter/model/article.dart';
import 'package:sampahku_flutter/view/detail_article_screen.dart';

class ArticleScreen extends StatefulWidget {
  const ArticleScreen({super.key});

  @override
  State<ArticleScreen> createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen> {
  @override
  Widget build(BuildContext context) {
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
                decoration: InputDecoration(
                    hintText: "Cari Artikel",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(60))),
              ),
              SizedBox(
                height: 10,
              ),
              article()
            ],
          ),
        ));
  }
  Widget article() {
    List<Article> articles = [
      Article("Judul Artikel", "ini adalah abstrak simpel",
          "https://dlh.bulelengkab.go.id/uploads/konten/66_sampah-plastik-cemari-sungai-di-indonesia.jpg"),
      Article("Judul Artikel", "ini adalah abstrak simpel",
          "https://dlh.bulelengkab.go.id/uploads/konten/66_sampah-plastik-cemari-sungai-di-indonesia.jpg")
    ];

    return SizedBox(        
        child: ListView.builder(            
            itemCount: articles.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Padding(
                  padding: EdgeInsets.all(5),
                  child: InkWell(
                    onTap: (){
                      _goToDetailArticle(articles[index]);
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
                              topLeft:
                                  Radius.circular(12), // Membulatkan kiri atas
                              bottomLeft:
                                  Radius.circular(12), // Membulatkan kiri bawah
                            ),
                          ),
                          height: 100,
                          width: 100,
                          clipBehavior: Clip.hardEdge,
                          child: Image.network(
                            articles[index].imgUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(articles[index].title,
                                  style: TextStyle(
                                      color: AppColor.secondaryColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18)),
                              Text(articles[index].desc,
                                  style: TextStyle(
                                      color: AppColor.primaryColor,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 14)),
                              Text(
                                "Baca Selengkapnya",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal,
                                    decoration: TextDecoration.underline,
                                    fontSize: 12),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  )),
                  ));
            }),);
  }
void _goToDetailArticle(Article article) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => DetailArticleScreen(article: article,)));
}
}

