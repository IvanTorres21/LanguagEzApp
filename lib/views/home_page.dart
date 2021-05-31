
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:languageez_app/widgets/Navbar.dart';

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
        top: false,
        child: Padding(
          padding: EdgeInsets.zero,
          child: Stack(
            children: [
              Positioned(
                top: 0,
                child: SvgPicture.asset('assets/svg/upper_decor.svg'),
              ),
              ListView(
                children: [

                ],
              ),
              Positioned(
                bottom: 0,
                child: NavBarWidget(0),
              )
            ],
          ),
        )
      ),
    );
  }
}