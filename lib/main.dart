import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sampahku_flutter/color/app_color.dart';
import 'package:sampahku_flutter/view/splash_screen.dart';
import 'package:sampahku_flutter/viewmodel/login_view_model.dart';
import 'package:sampahku_flutter/viewmodel/profile_view_model.dart';
import 'package:sampahku_flutter/viewmodel/register_view_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();
  runApp(
    MultiProvider(child: const MyApp(),
        providers: [ChangeNotifierProvider(create: (_) => LoginViewModel()),
        ChangeNotifierProvider(create: (_) => RegisterViewModel()),
        ChangeNotifierProvider(create: (_) => ProfileViewModel())]),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'sampahku.id',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColor.primaryColor),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
