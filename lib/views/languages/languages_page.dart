
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:languageez_app/constants/text_styles.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:languageez_app/utility/language_utility.dart';
import 'package:languageez_app/widgets/Cards/language_card.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LanguagePageView extends StatefulWidget {


  @override
  State<StatefulWidget> createState() {
    return LanguagePageState();
  }
}

class LanguagePageState extends State<LanguagePageView> {

  LanguageController _languageController = LanguageController();

  @override
  void initState() {
    _prepareLanguages();
    super.initState();
  }

  _prepareLanguages() async {
    await _languageController.receiveLanguages();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 40),
          child: ListView(
            children: getLanguagesCards(),
          ),
        ),
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
                '${AppLocalizations.of(context).languages}',
                style: titleStyle,
              ),
            )
        ),

      ],
    );
  }

  List<Widget> getLanguagesCards() {
    List<Widget> cards = [];
    _languageController.languages.forEach((element) {
      cards.add(
        Padding(
          padding: EdgeInsets.only(bottom: 25),
          child: LanguageCard(element),
        )
      );
    });
    return cards;
  }
}