import 'package:flutter/material.dart';
import 'package:sampahku_flutter/color/app_color.dart';
import 'package:sampahku_flutter/model/history.dart';
import 'package:sampahku_flutter/repository/remote/api_service.dart';
import 'package:sampahku_flutter/repository/remote/response/history_prediction_response.dart';
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
      body: Padding(
        padding: EdgeInsets.all(20),
        child: predicts(),
      ),
    );
  }

  Widget predicts() {
    return FutureBuilder<List<HistoryData>>(
      future: ApiService().fetchHistoryPrediction().then((response) {
        return response.data; // Return the list of history data
      }),
      builder: (context, snapshot) {
        List<HistoryData>? predicts = snapshot.data;

        if (snapshot.connectionState == ConnectionState.waiting) {
          // Show loading indicator while data is being fetched
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          // Handle error state
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          // Handle empty data
          return Center(child: Text('No data available'));
        } else {
          List<HistoryData>? predicts = snapshot.data;
          return SizedBox(
            child: ListView.builder(
                itemCount: predicts!.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Padding(
                      padding: EdgeInsets.all(5),
                      child: InkWell(
                        onTap: () {
                          _goToDetailHistory(predicts[index]);
                        },
                        child: Card(
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.zero)),
                            child: SizedBox(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 80,
                                    width: 80,
                                    child: Image.network(
                                      predicts[index]!.result.imgUrl,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Expanded(child: Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(
                                            predicts[index]
                                                .result
                                                .predict
                                                .category,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14)),
                                        Text(
                                            predicts[index]
                                                .result
                                                .predict
                                                .suggestion, // Use suggestion
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1, // Limit to 1 line
                                            style: TextStyle(
                                                color: AppColor.primaryColor,
                                                fontWeight: FontWeight.normal,
                                                fontSize: 14)),
                                        Text(
                                          "Baca Selengkapnya",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.normal,
                                            decoration:
                                                TextDecoration.underline,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ))
                                ],
                              ),
                            )),
                      ));
                }),
          );
        }
      },
    );
  }

  void _goToDetailHistory(HistoryData history) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DetailHistoryScreen(
                  history: history,
                )));
  }
  
}
