import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:languageez_app/constants/text_styles.dart';
import 'package:languageez_app/utility/lesson_utility.dart';
import 'package:languageez_app/views/languages/lessons/lesson_detail.dart';
import 'package:languageez_app/widgets/Buttons/dynamic_color_raised_button.dart';
import 'package:languageez_app/widgets/Buttons/dynamic_raised_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MinigamesPage extends StatefulWidget {

  int id;

  MinigamesPage(this.id);

  @override
  State<StatefulWidget> createState() {
    return MinigamesPageState();
  }
}

class MinigamesPageState extends State<MinigamesPage> {

  Locale myLocale;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    myLocale = Localizations.localeOf(context);
    return Scaffold(
      body: Stack(
        children: [

          Padding(
            padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: MediaQuery.of(context).size.height / 2.3 + 40),
            child: ListView(
                children: [

                ]
            ),
          ),
          Positioned(
            top: 0,
            child: SvgPicture.asset('assets/svg/upper_decor.svg'),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height / 8,
                  right: MediaQuery.of(context).size.width / 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SvgPicture.asset(
                    'assets/icons/minigame.svg',
                    width: 70,
                    color: Theme.of(context).accentColor,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                        child: Text(
                          '${AppLocalizations.of(context).minigames}',
                          style: titleBlackStyle,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
              top: 0,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
                child: IconButton(
                  icon: Icon(Icons.arrow_back_ios, color: Color(0xFFFAFAFA), size: 35,),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              )
          ),
        ],
      ),
    );
  }

}