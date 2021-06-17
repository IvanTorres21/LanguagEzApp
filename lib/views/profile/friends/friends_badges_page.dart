
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:languageez_app/constants/text_styles.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:languageez_app/models/badge.dart';
import 'package:languageez_app/models/user.dart';
import 'package:languageez_app/utility/badge_utility.dart';
import 'package:languageez_app/utility/user_controller.dart';
import 'package:languageez_app/views/profile/friends/friends_page.dart';
import 'package:languageez_app/widgets/TextFields/InputField.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FriendBadgesPage extends StatefulWidget {

  int id;

  FriendBadgesPage(this.id);

  @override
  State<StatefulWidget> createState() {
    return FriendBadgesPageState();
  }
}

class FriendBadgesPageState extends State<FriendBadgesPage> {

  List<Badge> badges = [];
  BadgeController _badgeController = BadgeController();
  Locale myLocale;
  bool loaded = false;

  @override
  void initState() {
    super.initState();
  }

  // loads badges
  _loadBadges() async {
    badges = await _badgeController.getFriendsBadges(this.widget.id);
    loaded = true;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    myLocale = Localizations.localeOf(context);
    if(!loaded) _loadBadges();
    return Scaffold(
      body: Stack(
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
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height / 7,
              left: 20,
              right: 20,),
            child: ListView(
                children: [
                  Center(
                    child:  Wrap(
                      children:  _getBadges(),
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height / 4,
                  )
                ]
            ),
          ),
          Positioned(
            bottom: 00,
            child: SvgPicture.asset('assets/svg/lower_decor.svg'),
          ),
          Positioned(
              bottom: 00,
              right: 0,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: Text(
                  '${AppLocalizations.of(context).badges.substring(0,1).toUpperCase()}${AppLocalizations.of(context).badges.substring(1)}',
                  style: titleStyle,
                ),
              )
          ),
        ],
      ),
    );
  }

  List<Widget> _getBadges() {
    List<Widget> widgets = [];
    badges.forEach((element) {
      widgets.add(
          Padding(
            padding: EdgeInsets.only(right: MediaQuery.of(context).size.width / 22, top: 10),
            child: GestureDetector(
              child:  Container(
                width: 70.0,
                height: 70.0,
                decoration: new BoxDecoration(
                  color: (element.assigned) ? Color(0xFF3A53C2) : Color(0xFF555555),
                  shape: BoxShape.circle,
                ),
                child: Container(),
              ),
              onTap: () async {
                await _dialog(element);
              },
            ),
          )
      );
    });
    return widgets;
  }

  /// Makes a dialog box
  Future<void> _dialog(Badge badge) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(badge.title[myLocale.languageCode]),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(badge.description[myLocale.languageCode]),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}