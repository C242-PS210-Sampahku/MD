import 'package:flutter/material.dart';
import 'package:sampahku_flutter/color/app_color.dart';
import 'package:sampahku_flutter/model/article.dart';

class DetailArticleScreen extends StatefulWidget {
  final Article article;
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: deviceWidth * 0.4,
                  width: deviceWidth,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.all(
                      Radius.circular(12),
                    ),
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: Image.network(
                    widget.article.imgUrl,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: deviceWidth * 0.1,
                ),
                Text(widget.article.desc)
              ],
            ),
          ),
        ));
  }
}
