import 'package:flutter/material.dart';
import 'package:sampahku_flutter/color/app_color.dart';
import 'package:sampahku_flutter/model/blog_post.dart';
import 'package:sampahku_flutter/model/reminder.dart';
import 'package:sampahku_flutter/preferences/user_preferences.dart';
import 'package:sampahku_flutter/model/article.dart';
import 'package:sampahku_flutter/model/quest.dart';
import 'package:sampahku_flutter/model/user.dart';
import 'package:sampahku_flutter/repository/remote/api_service.dart';
import 'package:sampahku_flutter/repository/remote/response/LoginResponse.dart';
import 'package:sampahku_flutter/repository/remote/response/history_prediction_response.dart';
import 'package:sampahku_flutter/repository/remote/response/reminder_response.dart';
import 'package:sampahku_flutter/view/calendar_screen.dart';
import 'package:sampahku_flutter/view/detail_article_screen.dart';
import 'package:sampahku_flutter/view/detail_history_screen.dart';
import 'package:table_calendar/table_calendar.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  var deviceWidth, deviceHeight;  
  int predictCount = 0;
  CalendarFormat _calendarFormat = CalendarFormat.month;


  @override
  void initState() {
    _loadReminders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    deviceWidth = MediaQuery.of(context).size.width;
    deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: FutureBuilder(
              future: UserPreference.getUserData(),
              builder: (context, snapshot) {
                UserData? user;
                if (snapshot.hasData) {
                  user = snapshot.data;
                }
                return AppBar(
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
                          FutureBuilder(
                              future: UserPreference.getUserData(),
                              builder: (context, snapshot) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    snapshot.data!.user != null
                                        ? Text(
                                            snapshot.data!.user!.providerData[0]
                                                .displayName
                                                .toString(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          )
                                        : Text(
                                            "Name",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          ),
                                    snapshot.data!.user != null
                                        ? Text(
                                            snapshot.data!.user!.providerData[0]
                                                .email
                                                .toString(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.normal,
                                                fontSize: 16,
                                                decoration:
                                                    TextDecoration.underline),
                                          )
                                        : Text(
                                            "Username",
                                            style: TextStyle(
                                                fontWeight: FontWeight.normal,
                                                fontSize: 16,
                                                decoration:
                                                    TextDecoration.underline),
                                          )
                                  ],
                                );
                              }),
                        ],
                      ),
                      Expanded(child: IconButton(
                          iconSize: 50,
                          onPressed: () {},
                          icon: Icon(
                            Icons.notifications,
                            color: Colors.white,
                          )))
                    ],
                  ),
                );
              })),
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
                  SizedBox(
                    height: 20,
                  ),
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
      padding: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FutureBuilder(
                    future: UserPreference.getUserData(),
                    builder: (context, snapshot) {
                      return Text(
                        "Halo, ${snapshot.data!.user!.providerData[0].displayName.toString()}!",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColor.secondaryColor,
                          fontSize: 18,
                        ),
                      );
                    }),
                Text(
                  softWrap: true,
                  overflow: TextOverflow.visible,
                  "sudah buang sampah hari ini?",
                  style: TextStyle(fontWeight: FontWeight.normal, fontSize: 14),
                ),
              ],
            ),
          ),

                    SizedBox(width: 5,),
          InkWell(
            child: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border:
                        Border.all(width: 1.5, color: AppColor.secondaryColor)),
                child: Expanded(
                  child: Row(
                    children: [
                      Icon(
                        Icons.calendar_month,
                        size: 40,
                      ),
                      Text(
                        "Lihat Jadwal",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 12),
                      )
                    ],
                  ),
                )),
            onTap: () async{

                await _loadReminders().then((value){
                  print("Data $value");
                  _goToCalendarScreen(value);
                });
                ;
              
            },
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
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                          width: 1.5, color: AppColor.secondaryColor)),
                  child: Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                            flex: 2,
                            child: Center(
                              child: Text("Jumlah Foto Sampah",
                                  softWrap: true,
                                  style: TextStyle(
                                      color: AppColor.primaryColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18)),
                            )),
                        Expanded(
                            child: FutureBuilder(
                                future: ApiService()
                                    .fetchHistoryPrediction()
                                    .then((response) {
                                  return response.data;
                                }),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Text("0000",
                                        style: TextStyle(
                                            color: AppColor.secondaryColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 25));
                                  } else {
                                    return Text(
                                      "${snapshot.data!.length.toString().padLeft(4, '0')}",
                                      style: TextStyle(
                                        color: AppColor.secondaryColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25,
                                      ),
                                    );
                                  }
                                }))
                      ],
                    ),
                  ))),
          // SizedBox(
          //   width: 10,
          // ),
          // Expanded(
          //     child: Container(
          //         padding: EdgeInsets.all(10),
          //         decoration: BoxDecoration(
          //             color: Colors.white,
          //             borderRadius: BorderRadius.circular(20),
          //             border: Border.all(
          //                 width: 1.5, color: AppColor.secondaryColor)),
          //         child: Expanded(
          //           child: Row(
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             children: [
          //               Expanded(
          //                   flex: 2,
          //                   child: Text("Jumlah Quest Selesai",
          //                       softWrap: true,
          //                       style: TextStyle(
          //                           color: AppColor.primaryColor,
          //                           fontWeight: FontWeight.bold,
          //                           fontSize: 18))),
          //               Expanded(
          //                   child: Text("00",
          //                       style: TextStyle(
          //                           color: AppColor.secondaryColor,
          //                           fontWeight: FontWeight.bold,
          //                           fontSize: 25)))
          //             ],
          //           ),
          //         )))
        ],
      ),
    );
  }

  Widget article() {
    return SizedBox(
        child: FutureBuilder(
            future: WordPressApi().fetchPosts(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<BlogPost> blogPost = snapshot.data!;
                return ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: blogPost.length,
                    itemBuilder: (context, index) {
                      return Container(
                          height: 100,
                          padding: EdgeInsets.all(10),
                          child: InkWell(
                              onTap: () => _goToDetailArticle(blogPost[index]),
                              child: Card(
                                  child: SizedBox(
                                height: 100,
                                width: deviceWidth * 0.7,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                        decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(
                                                12), // Membulatkan kiri atas
                                            bottomLeft: Radius.circular(
                                                12), // Membulatkan kiri bawah
                                          ),
                                        ),
                                        height: 100,
                                        width: 100,
                                        clipBehavior: Clip.hardEdge,
                                        child: FutureBuilder(
                                            future: blogPost[index]
                                                .fetchFeaturedImage(),
                                            builder: (context, snapshot) {
                                              if (snapshot.connectionState ==
                                                  ConnectionState.done) {
                                                return blogPost[index]
                                                            .featuredMediaId !=
                                                        0
                                                    ? Image.network(
                                                        blogPost[index]
                                                            .featuredImage
                                                            .sourceUrl,
                                                        fit: BoxFit.cover)
                                                    : Image.network(
                                                        "https://via.placeholder.com/100",
                                                      );
                                              } else {
                                                return Image.network(
                                                    "https://via.placeholder.com/100",
                                                    fit: BoxFit.cover);
                                              }
                                            })),
                                    Expanded(
                                        child: Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Text(blogPost[index].title,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1, // Limit to 1 line
                                              style: TextStyle(
                                                  color:
                                                      AppColor.secondaryColor,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18)),
                                          Text(
                                              removeHtmlTags(_getExcerpt(
                                                  blogPost[index].excerpt)),
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
                                                fontSize: 12),
                                          )
                                        ],
                                      ),
                                    ))
                                  ],
                                ),
                              ))));
                    });
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text('No articles available'));
              } else {
                return Center(child: Text('No articles available'));
              }
            }),
        height: 120);
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

  void _goToDetailHistory(HistoryData history) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DetailHistoryScreen(
                  history: history,
                )));
  }

  Widget history() {
    // Fetching the history data using Future
    return FutureBuilder<List<HistoryData>>(
      future: ApiService().fetchHistoryPrediction().then((response) {
        return response.data; // Return the list of history data
      }),
      builder: (context, snapshot) {
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
          List<HistoryData> predict = snapshot.data!;

          return SizedBox(
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: predict.length,
              itemBuilder: (context, index) {
                var historyItem = predict[index];

                return InkWell(
                    onTap: () {
                      _goToDetailHistory(historyItem);
                    },
                    child: Container(
                      height: 100,
                      padding: EdgeInsets.all(10),
                      child: Card(
                        child: SizedBox(
                          height: 100,
                          width: deviceWidth * 0.7,
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
                                child: Image.network(
                                  historyItem
                                      .result.imgUrl, // Use imgUrl from result
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1, // Limit to 1 line
                                        historyItem.result.predict
                                            .category, // Use suggestion
                                        style: TextStyle(
                                          color: AppColor.secondaryColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                      Text(
                                          historyItem.result.predict
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
                                          decoration: TextDecoration.underline,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ));
              },
            ),
            height: 120,
          );
        }
      },
    );
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
      children: [
        Container(
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
        ),
        Container(
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
                }))
      ],
    );
  }
Future<Map<DateTime, List<String>>> _loadReminders() async {
  ApiService apiService = ApiService();
  ReminderResponse response = await apiService.getReminder();

  Map<String, int> dayMap = {
    "monday": DateTime.monday,
    "tuesday": DateTime.tuesday,
    "wednesday": DateTime.wednesday,
    "thursday": DateTime.thursday,
    "friday": DateTime.friday,
    "saturday": DateTime.saturday,
    "sunday": DateTime.sunday,
  };

  Map<DateTime, List<String>> events = {};

  // Iterasi melalui daftar pengingat
  for (ReminderModel reminder in response.reminders!) {
    String day = reminder.day.toLowerCase();
    if (dayMap.containsKey(day)) {
      int weekday = dayMap[day]!;
      DateTime now = DateTime.now();

      // Cari tanggal berikutnya sesuai hari
      DateTime nextDate = now.add(Duration(days: (weekday - now.weekday) % 7));

      // Normalisasi tanggal (hanya mempertimbangkan tahun, bulan, dan hari)
      DateTime normalizedDate = DateTime(nextDate.year, nextDate.month, nextDate.day);

      // Menambahkan pengingat untuk tanggal yang telah dinormalisasi
      if (!events.containsKey(normalizedDate)) {
        events[normalizedDate] = [];
      }
      events[normalizedDate]?.add(reminder.time);
    }
  }

  return events;
}



  void _goToCalendarScreen(var reminder) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CalendarScreen(reminders: reminder,),
      ),
    );
  }

}

