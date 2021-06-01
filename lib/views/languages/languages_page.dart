
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:languageez_app/constants/text_styles.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LanguagePageView extends StatefulWidget {


  @override
  State<StatefulWidget> createState() {
    return LanguagePageState();
  }
}

class LanguagePageState extends State<LanguagePageView> {


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          bottom: 60,
          child: SvgPicture.asset('assets/svg/lower_decor.svg'),
        ),
        Positioned(
            bottom: 60,
            right: 0,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              child: Text(
                'Languages',
                style: titleStyle,
              ),
            )
        ),
        ListView(
          children: [
            //TODO: Get Languages
          ],
        ),
      ],
    );
  }
}