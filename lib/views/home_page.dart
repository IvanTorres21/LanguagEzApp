
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePageView extends StatefulWidget {


  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePageView> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [],
        ),
      ),
    );
  }
}