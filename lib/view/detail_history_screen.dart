import 'package:flutter/material.dart';
import 'package:sampahku_flutter/color/app_color.dart';
import 'package:sampahku_flutter/model/history.dart';

class DetailHistoryScreen extends StatefulWidget {
  final History history;
  const DetailHistoryScreen({super.key, required this.history});

  @override
  State<DetailHistoryScreen> createState() => _DetailHistoryScreenState();
}

class _DetailHistoryScreenState extends State<DetailHistoryScreen> {
  var deviceWidth;

  @override
  Widget build(BuildContext context) {
    deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.thirthyColor,
          title: Text("History Hasil Prediksi",
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
                  height: deviceWidth * 0.8,
                  width: deviceWidth,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.all(
                      Radius.circular(12),
                    ),
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: Image.network(
                    widget.history.imgUrl,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: deviceWidth * 0.05,
                ),
                Text(widget.history.date,
                    style:
                        TextStyle(fontWeight: FontWeight.normal, fontSize: 22)),
                SizedBox(
                  height: deviceWidth * 0.05,
                ),
                Text("Result",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColor.secondaryColor,
                        fontSize: 22)),
                Text(widget.history.result,
                    style:
                        TextStyle(fontWeight: FontWeight.normal, fontSize: 14)),
                SizedBox(
                  height: deviceWidth * 0.05,
                ),
                Text("Suggestion",
                    style: TextStyle(
                        color: AppColor.secondaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 22)),
                Text(widget.history.suggestion,
                    style:
                        TextStyle(fontWeight: FontWeight.normal, fontSize: 14)),
                
              ],
            ),
          ),
        ));
  }
}
