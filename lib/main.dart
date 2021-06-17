import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:languageez_app/views/login/login_page.dart';
import 'package:languageez_app/views/login/signup_page.dart';
import 'package:languageez_app/views/main_page.dart';
import 'package:languageez_app/views/splash.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyAppState createState() => MyAppState();

  static MyAppState of(BuildContext context) => context.findAncestorStateOfType<MyAppState>();
}


class MyAppState extends State<MyApp> {
  Locale _locale;
  FlutterSecureStorage _storage = FlutterSecureStorage();

  void setLocale(Locale value) {
    setState(() {
      _locale = value;
    });
  }

  void getLocale() async {
    if(await _storage.containsKey(key: 'locale'))
      setLocale(Locale.fromSubtags(languageCode: await _storage.read(key: 'locale')));
  }

  @override
  void initState() {
    getLocale();
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: _locale,
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', ''),
        const Locale('es', '')
      ],
      title: 'LanguagEz',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        backgroundColor: Color(0xFFFAFAFA),
        highlightColor: Color(0xFF2D2D2D),
        shadowColor: Color(0x552D2D2D),
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