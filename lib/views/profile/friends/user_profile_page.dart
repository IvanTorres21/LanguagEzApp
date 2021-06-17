
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:languageez_app/constants/text_styles.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:languageez_app/models/user.dart';
import 'package:languageez_app/utility/user_controller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:languageez_app/views/profile/friends/friends_badges_page.dart';

class UserProfilePage extends StatefulWidget {

  User friend;

  UserProfilePage(this.friend);

  @override
  State<StatefulWidget> createState() {
    return UserProfilePageState();
  }
}

class UserProfilePageState extends State<UserProfilePage> {

  UserController _userController = UserController();

  @override
  void initState() {
    _userController.user = this.widget.friend;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            bottom: 0,
            child: SvgPicture.asset('assets/svg/lower_decor.svg'),
          ),
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
          Positioned(
              bottom: 20,
              right: 0,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: Text(
                  '${AppLocalizations.of(context).profile}',
                  style: titleStyle,
                ),
              )
          ),
          Padding(
            padding: EdgeInsets.only(top: 90),
            child: ListView(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 20, top: 0),
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
                        width: MediaQuery.of(context).size.width * (_userController.user.exp / (200  * (_userController.user.level+1))), // here you can define your percentage of progress, 0.2 = 20%, 0.3 = 30 % .....
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
                        Text('${_userController.user.username} ${AppLocalizations.of(context).badges}', style: titleBlackStyle.merge(TextStyle(fontSize: 26)))
                      ],
                    ),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => FriendBadgesPage(_userController.user.id)));
                    },
                  )
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}