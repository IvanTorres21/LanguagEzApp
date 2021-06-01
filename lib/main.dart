import 'package:flutter/material.dart';
import 'package:languageez_app/views/dictionary/dictionaries_page.dart';
import 'package:languageez_app/views/home_page.dart';
import 'package:languageez_app/views/login/login_page.dart';
import 'package:languageez_app/views/login/signup_page.dart';
import 'package:languageez_app/views/main_page.dart';
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
        '/home' : (context) => MainPageView(0),
        '/languages' : (context) => MainPageView(1),
        '/dictionary' : (context) => MainPageView(2),
        '/profile' : (context) => MainPageView(3),
        '/signup' : (context) => SignUpPageView(),
        '/login' : (context) => LoginPageView()
      },
      home: SplashView(),
    );
  }
}

