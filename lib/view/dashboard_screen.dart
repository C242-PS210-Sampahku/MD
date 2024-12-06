import 'package:flutter/material.dart';
import 'package:sampahku_flutter/color/app_color.dart';
import 'package:sampahku_flutter/model/article.dart';
import 'package:sampahku_flutter/model/quest.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  var deviceWidth, deviceHeight;
  @override
  Widget build(BuildContext context) {
    deviceWidth = MediaQuery.of(context).size.width;
    deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          backgroundColor: AppColor.thirthyColor,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(100)),
                    child: Icon(Icons.person),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Name",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Text(
                        "Username",
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 16,
                            decoration: TextDecoration.underline),
                      )
                    ],
                  ),
                ],
              ),
              IconButton(
                  iconSize: 50,
                  onPressed: () {},
                  icon: Icon(
                    Icons.notifications,
                    color: Colors.white,
                  ))
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            header(),
            counter(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text("Artikel Edukasi Sampah",
                      style: TextStyle(
                          color: AppColor.primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18)),
                  Divider(
                    thickness: 2,
                    color: AppColor.thirthyColor,
                  ),
                ],
              ),
            ),
            article(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("History",
                      style: TextStyle(
                          color: AppColor.primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18)),
                  Divider(
                    thickness: 2,
                    color: AppColor.thirthyColor,
                  ),
                ],
              ),
            ),
            history(),
          ],
        ),
      ),
    );
  }

  Widget header() {
    return Container(
      padding: EdgeInsets.all(30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Halo, Nama user",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColor.secondaryColor,
                    fontSize: 18,
                  ),
                ),
                Text(
                  softWrap: true,
                  overflow: TextOverflow.visible,
                  "sudah buang sampah hari ini?",
                  style: TextStyle(fontWeight: FontWeight.normal, fontSize: 14),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(width: 1.5, color: AppColor.secondaryColor)),
            child: Expanded(child: Row(
              children: [
                Icon(
                  Icons.calendar_month,
                  size: 40,
                ),
                Text(
                  "Lihat Jadwal",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                )
              ],
            ),)
          )
        ],
      ),
    );
  }

  Widget counter() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
              child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                          width: 1.5, color: AppColor.secondaryColor)),
                  child: Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            flex: 2,
                            child: Text("Jumlah Foto Sampah",
                                softWrap: true,
                                style: TextStyle(
                                    color: AppColor.primaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18))),
                        Expanded(
                            child: Text("00",
                                style: TextStyle(
                                    color: AppColor.secondaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25)))
                      ],
                    ),
                  ))),
                  SizedBox(width: 10,),
          Expanded(
              child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                          width: 1.5, color: AppColor.secondaryColor)),
                  child: Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            flex: 2,
                            child: Text("Jumlah Quest Selesai",
                                softWrap: true,
                                style: TextStyle(
                                    color: AppColor.primaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18))),
                        Expanded(
                            child: Text("00",
                                style: TextStyle(
                                    color: AppColor.secondaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25)))
                      ],
                    ),
                  )))
        ],
      ),
    );
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
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: articles.length,
            itemBuilder: (context, index) {
              return Container(
                  height: 100,
                  padding: EdgeInsets.all(10),
                  child: Card(
                      child: SizedBox(
                    height: 100,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.red,
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
                  )));
            }),
        height: 120);
  }

  Widget history() {
    List<Article> articles = [
      Article("Judul Artikel", "ini adalah abstrak simpel",
          "https://dlh.bulelengkab.go.id/uploads/konten/66_sampah-plastik-cemari-sungai-di-indonesia.jpg"),
      Article("Judul Artikel", "ini adalah abstrak simpel",
          "https://dlh.bulelengkab.go.id/uploads/konten/66_sampah-plastik-cemari-sungai-di-indonesia.jpg")
    ];

    return SizedBox(
        child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: articles.length,
            itemBuilder: (context, index) {
              return Container(
                  height: 100,
                  padding: EdgeInsets.all(10),
                  child: Card(
                      child: SizedBox(
                    height: 100,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.red,
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
                  )));
            }),
        height: 120);
  }

  Widget quest() {
    var quests = [
      Quest("Buang Sampah Botol",
          "buang sampah botol dan foto untuk dapatkan 50 point", 50),
      Quest("Buang Sampah Botol",
          "buang sampah botol dan foto untuk dapatkan 50 point", 50),
      Quest("Buang Sampah Botol",
          "buang sampah botol dan foto untuk dapatkan 50 point", 50)
    ];

    var isChecked = false;

    

    return Column(
      children: [Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Quest Harian",
                      style: TextStyle(
                          color: AppColor.primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18)),
                  Divider(
                    thickness: 2,
                    color: AppColor.thirthyColor,
                  ),
                ],
              ),
            ),Container(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: quests.length,
            itemBuilder: (context, index) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(quests[index].title),
                  Checkbox(value: isChecked, onChanged: (status) {})
                ],
              );
            }))],
    );
  }
}
