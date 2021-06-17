
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:languageez_app/constants/text_styles.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:languageez_app/main.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:languageez_app/utility/user_controller.dart';

class SelectLanguagePage extends StatefulWidget {


  @override
  State<StatefulWidget> createState() {
    return SelectLanguagePageState();
  }
}

class SelectLanguagePageState extends State<SelectLanguagePage> {

  Locale myLocale;
  UserController _userController = UserController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    myLocale = Localizations.localeOf(context);
    return Scaffold(
      body:  Stack(
        children: [
          Positioned(
            top: 50,
            left:  20,
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios,  color: Color(0xFF4969F5), size: 35,),
              onPressed: ()  {
                Navigator.pop(context);
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 30, right: 30, top: 100),
            child: ListView(
              children: [
                GestureDetector(
                  child: Container(
                    color: myLocale.languageCode == 'es' ? Color(0xFF96FF85) : Color(0x00),
                    child: Row(
                      children: [
                        SvgPicture.asset('assets/svg/spain.svg', width: 35,),
                        SizedBox(width: 10,),
                        Text('${AppLocalizations.of(context).spanish}', style: titleBlackStyle.merge(TextStyle(fontSize: 20)),)
                      ],
                    ),
                  ),
                  onTap: () {
                    _userController.changeLocale('es');
                    MyApp.of(context).setLocale(Locale.fromSubtags(languageCode: 'es'));
                  },
                ),
                SizedBox(height: 20,),
               GestureDetector(
                 child:  Container(
                     color: myLocale.languageCode == 'en' ? Color(0xFF96FF85) : Color(0x00),
                     child: Row(
                       children: [
                         SvgPicture.asset('assets/svg/uk.svg', width: 35,),
                         SizedBox(width: 10,),
                         Text('${AppLocalizations.of(context).english}', style: titleBlackStyle.merge(TextStyle(fontSize: 20)))
                       ],
                     )
                 ),
                 onTap: () {
                   _userController.changeLocale('en');
                   MyApp.of(context).setLocale(Locale.fromSubtags(languageCode: 'en'));
                 },
               )
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            child: SvgPicture.asset('assets/svg/lower_decor.svg'),
          ),
          Positioned(
              bottom: 0,
              right: 0,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: Text(
                  '${AppLocalizations.of(context).select_language}',
                  style: titleStyle,
                ),
              )
          ),

        ],
      ),
    );
  }
}