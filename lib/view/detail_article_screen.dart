import 'package:flutter/material.dart';
import 'package:sampahku_flutter/color/app_color.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:sampahku_flutter/model/blog_post.dart';

class DetailArticleScreen extends StatefulWidget {
  final BlogPost article;
  const DetailArticleScreen({required this.article, super.key});

  @override
  State<DetailArticleScreen> createState() => _DetailArticleScreenState();
}

class _DetailArticleScreenState extends State<DetailArticleScreen> {
  var deviceWidth;

  @override
  Widget build(BuildContext context) {
    deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.thirthyColor,
          title: Text("Artikel Edukasi Sampah",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: HtmlWidget(widget.article.content)
          ),
        ));
  }
}
