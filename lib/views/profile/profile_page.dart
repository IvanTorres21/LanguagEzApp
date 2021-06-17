
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:languageez_app/constants/text_styles.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:languageez_app/models/user.dart';
import 'package:languageez_app/utility/user_controller.dart';
import 'package:languageez_app/views/profile/badges_page.dart';
import 'package:languageez_app/views/profile/friends/friends_page.dart';
import 'package:languageez_app/widgets/TextFields/InputField.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfilePageView extends StatefulWidget {


  @override
  State<StatefulWidget> createState() {
    return ProfilePageState();
  }
}

class ProfilePageState extends State<ProfilePageView> {

  UserController _userController = UserController();

  @override
  void initState() {
    _userController.user = User();
    _loadUser();
    super.initState();
  }

  // loads user profile
  _loadUser() async {
    await _userController.loadProfile();
    setState(() {});
  }

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
                '${AppLocalizations.of(context).profile}',
                style: titleStyle,
              ),
            )
        ),
        ListView(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 20, top: 30),
              child: Text(_userController.user.username, style: titleBlackStyle.merge(TextStyle(fontSize: 26)),),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, top: 0),
              child: Text(_userController.user.email, style: emailProfileStyle),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Divider(thickness: 2,),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, top: 0),
              child: Text('${AppLocalizations.of(context).level} ${_userController.user.level}', style: titleBlackStyle.merge(TextStyle(fontSize: 26))),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 30),
              child:Stack(
                children: <Widget>[
                  Container(
                    color: Color(0xff94A6F7),
                    width: MediaQuery.of(context).size.width,
                    height: 25,
                  ),
                  Container(
                    color: Color(0xFF4969F5),
                    width: MediaQuery.of(context).size.width * (_userController.user.exp / (200  * (_userController.user.level+1))),
                    height: 25,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 4),
                    child: Center(
                      child: Text(
                          '${_userController.user.exp}/${200 * (_userController.user.level+1)}',
                        style: titleStyle.merge(TextStyle(fontSize: 15)),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, top: 20),
              child: GestureDetector(
                child: Row(
                  children: [
                    SvgPicture.asset('assets/icons/badges.svg', width: 40,),
                    SizedBox(width: 10,),
                    Text('${AppLocalizations.of(context).my_badges}', style: titleBlackStyle.merge(TextStyle(fontSize: 26)))
                  ],
                ),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => BadgesPage()));
                },
              )
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, top: 30),
              child: GestureDetector(
                child: Row(
                  children: [
                    SvgPicture.asset('assets/icons/friends.svg', width: 40,),
                    SizedBox(width: 10,),
                    Text('${AppLocalizations.of(context).my_friends}', style: titleBlackStyle.merge(TextStyle(fontSize: 26)))
                  ],
                ),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => FriendPageView()));
                },
              )
            ),
          ],
        ),
      ],
    );
  }


}