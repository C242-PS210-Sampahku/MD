import 'package:flutter/material.dart';
import 'package:sampahku_flutter/color/app_color.dart';
import 'package:sampahku_flutter/model/history.dart';
import 'package:sampahku_flutter/view/detail_article_screen.dart';
import 'package:sampahku_flutter/view/detail_history_screen.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.thirthyColor,
          title: Text("History Foto Sampah",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          centerTitle: true,
        ),
        body: Padding(padding: EdgeInsets.all(20)
        ,child: histories(),),);
  }

  Widget histories() {
    List<History> histories = [
      History("#1","29-07-2024", "ini adalah deskripsi ",
          "https://dlh.bulelengkab.go.id/uploads/konten/66_sampah-plastik-cemari-sungai-di-indonesia.jpg","hasil prediksi", "sugession"),
      History("#2","29-09-2024", "ini adalah deskripsi ",
          "https://dlh.bulelengkab.go.id/uploads/konten/66_sampah-plastik-cemari-sungai-di-indonesia.jpg","hasil prediksi", "sugession"),
          History("#3","09-05-2024", "ini adalah deskripsi ",
          "https://dlh.bulelengkab.go.id/uploads/konten/66_sampah-plastik-cemari-sungai-di-indonesia.jpg","hasil prediksi", "sugession"),
    ];

    return SizedBox(        
        child: ListView.builder(            
            itemCount: histories.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Padding(
                  padding: EdgeInsets.all(5),
                  child: InkWell(
                    onTap: (){
                      _goToDetailHistory(histories[index]);
                    },
                    child: Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.zero)
                    ),
                      child: SizedBox(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 80,
                          width: 80,
                          child: Image.network(
                            histories[index].imgUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(histories[index].id,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14)),
                              Text(histories[index].date,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14)),
                              Text(histories[index].desc,
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 14)),
                              
                            ],
                          ),
                        )
                      ],
                    ),
                  )),
                  ));
            }),);
  }
void _goToDetailHistory(History history) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => DetailHistoryScreen(history: history,)));
}
}