import 'package:flutter/material.dart';
import 'package:sampahku_flutter/color/app_color.dart';
import 'package:sampahku_flutter/model/history.dart';
import 'package:sampahku_flutter/repository/remote/response/history_prediction_response.dart';
import 'package:sampahku_flutter/repository/remote/response/predict_response.dart';

class DetailHistoryScreen extends StatefulWidget {
  HistoryData? history;
  PredictionData? data;
  DetailHistoryScreen({super.key,this.history,this.data});

  @override
  State<DetailHistoryScreen> createState() => _DetailHistoryScreenState();
}

class _DetailHistoryScreenState extends State<DetailHistoryScreen> {
  var deviceWidth;

  @override
  Widget build(BuildContext context) {
    deviceWidth = MediaQuery.of(context).size.width;
    if(widget.history != null){
      return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.thirthyColor,
          title: Text("Hasil Prediksi",
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
                    widget.history!.result.imgUrl,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: deviceWidth * 0.05,
                ),
                Text("Result",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColor.secondaryColor,
                        fontSize: 22)),
                Text(widget.history!.result.predict.category,
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
                Text(widget.history!.result.predict.suggestion,
                    style:
                        TextStyle(fontWeight: FontWeight.normal, fontSize: 14)),
                
              ],
            ),
          ),
        ));
    }else{
      return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.thirthyColor,
          title: Text("Hasil Prediksi",
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
                    widget.data!.photoUrl,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: deviceWidth * 0.05,
                ),
                Text("Result",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColor.secondaryColor,
                        fontSize: 22)),
                Text(widget.data!.prediction.category,
                    style:
                        TextStyle(fontWeight: FontWeight.normal, fontSize: 14)),
                SizedBox(
                  height: deviceWidth * 0.05,
                ),
                Text("Confidence",
                    style: TextStyle(
                        color: AppColor.secondaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 22)),
                Text(widget.data!.prediction.confidence.toString(),
                    style:
                        TextStyle(fontWeight: FontWeight.normal, fontSize: 14)),
                        SizedBox(
                  height: deviceWidth * 0.05,
                ),
                
              ],
            ),
          ),
        ));
    }
  }
}
