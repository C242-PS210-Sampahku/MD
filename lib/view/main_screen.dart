import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:sampahku_flutter/color/app_color.dart';
import 'package:sampahku_flutter/view/article_screen.dart';
import 'package:sampahku_flutter/view/dashboard_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  // Daftar ikon untuk navigasi
  final List<IconData> _iconList = [
    Icons.home,
    Icons.article,
    Icons.history,
    Icons.person,
  ];

  // Daftar widget untuk setiap halaman
  final List<Widget> _pages = [
    DashboardScreen(),
    ArticleScreen(),
    Center(child: Text('Notifications Page')),
    Center(child: Text('Profile Page')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex], // Menampilkan halaman sesuai tab
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.secondaryColor,
        shape: CircleBorder(),
        onPressed: () {
          
        },
        child: const Icon(Icons.online_prediction, color: Colors.white,size: 35,),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar(
        icons: _iconList,
        activeIndex: _currentIndex,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.softEdge,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        activeColor: AppColor.secondaryColor,
        inactiveColor: Colors.grey,
        backgroundColor: AppColor.primaryColor,
      ),
    );
  }
}