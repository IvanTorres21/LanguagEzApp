import 'package:flutter/material.dart';
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
      theme: ThemeData(
        backgroundColor: Color(0xFAFAFA),
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashView(),
    );
  }
}

