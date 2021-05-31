import 'package:flutter/material.dart';
import 'package:languageez_app/views/home_page.dart';
import 'package:languageez_app/views/splash.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LanguagEz',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        backgroundColor: Color(0xFAFAFA),
        accentColor: Color(0xFF4969F5),
        cardColor: Color(0xFF384478),
        bottomAppBarColor: Color(0xFF3A53C2),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {
        '/home' : (context) => HomePageView()
      },
      home: SplashView(),
    );
  }
}

