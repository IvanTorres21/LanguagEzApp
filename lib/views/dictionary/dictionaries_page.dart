
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:languageez_app/constants/text_styles.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DictionaryPageView extends StatefulWidget {


  @override
  State<StatefulWidget> createState() {
    return DictionaryPageState();
  }
}

class DictionaryPageState extends State<DictionaryPageView> {


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
                'Dictionaries',
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