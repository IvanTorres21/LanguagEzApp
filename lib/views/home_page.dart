
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:languageez_app/constants/text_styles.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePageView extends StatefulWidget {


  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePageView> {


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 0,
          child: SvgPicture.asset('assets/svg/upper_decor.svg'),
        ),
        Positioned(
            top: 0,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 50, horizontal: 10),
              child: Text(
                'Welcome to \n    LanguagEz!',
                style: titleStyle,
              ),
            )
        ),
        ListView(
          children: [
            //TODO: Get notifications
          ],
        ),
      ],
    );
  }
}