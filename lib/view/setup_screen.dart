import 'package:flutter/material.dart';
import 'package:sampahku_flutter/color/app_color.dart';
import 'package:sampahku_flutter/view/dashboard_screen.dart';

class SetupScreen extends StatefulWidget {
  const SetupScreen({super.key});

  @override
  State<SetupScreen> createState() => _SetupScreenState();
}

class _SetupScreenState extends State<SetupScreen> {
  var questions = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Container(
          padding: EdgeInsets.only(left: 30, right: 30),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 30,
                ),
                Text(
                  "Hore Akun Kamu Terdaftar!",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: AppColor.secondaryColor),
                ),
                Text(
                    "Sebelum lanjut, kami mau tau dulu nih. Kapan aja sih kamu buang sampah?"),
                SizedBox(
                  height: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Jadwal harian buang sampah",
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 14,
                          color: Colors.black),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ListView.builder(
                        itemCount: questions,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Container(
                            padding: EdgeInsets.only(top: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: (){
                                  print("day");
                                },
                                child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Icon(Icons.calendar_month_rounded),
                                  SizedBox(width: 5),
                                  Text("Day")
                                ],
                              ),
                              ),
                              InkWell(
                                onTap: (){
                                  print("time");
                                },
                                child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Icon(Icons.access_time_filled),
                                  SizedBox(width: 5),
                                  Text("00:00")
                                ],
                              ),
                              ),
                              IconButton(onPressed: (){
                                if(questions>1){
                                  setState(() {
                                    questions -= 1;
                                  });
                                }
                              }, icon: Icon(Icons.delete))
                            ],
                          ));
                        })
                  ],
                ),
                Center(
                  child: SizedBox(
                    width: double.infinity,
                    child: TextButton(onPressed: () {
                        if(questions<7){
                          setState(() {
                            questions += 1;
                          });
                        }
                      }, child: Text("Tambah"))
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Center(
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        goToDashboard();
                      },
                      child: Text("Selanjutnya"),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.secondaryColor,
                          foregroundColor: Colors.white,
                          textStyle: TextStyle(color: Colors.white)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: InkWell(
                    child: Text("Lewatkan bagian ini"),
                    onTap: () {
                        goToDashboard();
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        )
        ));
  }

  void goToDashboard() {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => DashboardScreen()),(route) => false,);
  }
}
